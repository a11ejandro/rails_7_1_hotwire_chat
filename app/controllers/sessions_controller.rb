class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: %i[ new create destroy ]

  def new
  end

  def create
    user = User.find_or_create_by(session_params)
    if user.persisted?
      session[:current_user_id] = user.id
      redirect_to hotwire_messages_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:current_user_id)
    redirect_to root_url
  end

  private

  def session_params
    params.require(:user).permit(:name)
  end
end
