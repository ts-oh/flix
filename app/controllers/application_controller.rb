class ApplicationController < ActionController::Base
  private

  def require_signin
    return if current_user

    session[:intended_url] = request.url
    redirect_to signin_url, alert: 'Please sign in!'
  end

  def require_admin
    return if current_user_admin?

    session[:intended_url] = request.url
    redirect_to root_url, alert: 'Unauthorized access!'
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  helper_method :current_user_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?
end
