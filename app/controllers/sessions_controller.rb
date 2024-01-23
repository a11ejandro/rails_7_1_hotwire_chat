class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: %i[ new create ]

  def new
  end

  def create
    user = User.find_or_create_by(session_params)
    if user.persisted?
      session[:current_user_id] = user.id
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def session_params
    params.require(:user).permit(:name)
  end
end
