class HotwireMessagesController < ApplicationController
  before_action :set_message, only: %i[ update edit destroy show ]
  before_action :authorize_message, except: %i[ index create ]

  def index
    @messages = Message.includes(:author).order(:created_at)
    @new_message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.author = current_user

    if @message.save
      @message.broadcast_append_to(
        'common',
        partial: 'hotwire_messages/message',
        target: 'messages',
        locals: { message: @message, current_user: current_user }
      )
    else
      render 'new', layout: false, status: :unprocessable_entity
    end
  end

  def update
    if @message.update(message_params)
      @message.broadcast_replace_to(
        'common',
        partial: 'hotwire_messages/message',
        target: @message,
        locals: { message: @message, current_user: current_user }
      )
    else
      render 'edit', layout: false, status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
    @message.destroy
    @message.broadcast_remove_to('common')
  end

  def show
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def authorize_message
    authorize @message
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
