module UsersHelper
  def log_in(user)
    session[:user_id] = user.id
    session[:session_token] = user.session_token
    current_user
  end

  def current_user
    return @current_user if @current_user.present?

    session[:user_id].present? ? set_user_through_session(session[:user_id]) : set_user_through_cookies(cookies.encrypted[:user_id])
  end

  def current_user?(user)
    user && user == current_user
  end

  def logged_in_user_only
    !current_user.nil?
  end

  def admin_only
    logged_in_user_only && current_user.admin?
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    reset_session
    @current_user = nil
  end

  def admin_user?
    @current_user.present? && @current_user.admin?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  private

  def set_user_through_session(user_id)
    user = User.find_by(id: user_id)
    @current_user = user if user && session[:session_token] == user.session_token
  end

  def set_user_through_cookies(user_id)
    user = User.find_by(id: user_id)
    if user && user.authenticated?(cookies[:remember_token])
      log_in user
      @current_user = user
    end
  end
end
