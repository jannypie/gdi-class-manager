class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate

  private

  def current_user
    @_current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    !!current_user
  end
  helper_method :logged_in?

  def authenticate
    unless logged_in?
      redirect_to new_session_path, alert: "Please log in."
      return false
    end
  end
end
