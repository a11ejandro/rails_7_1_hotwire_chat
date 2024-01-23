class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user

  private

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id]) if session[:current_user_id]
  end

  def authenticate_user
    redirect_to root_url unless current_user
  end


  def user_not_authorized
    head :forbidden
  end
end
