class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def redirect_if_not_signed_in
    redirect_to new_session_path, notice: "Please sign in!" and return if current_user.nil?
  end

  def redirect_if_unauthorized
    redirect_to root_path, notice: "Not authorized!" and return unless current_user.present? && current_user.is_admin?
  end

  def user_has_taken_quiz
    current_user && current_user.personality
  end
  helper_method :user_has_taken_quiz

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
