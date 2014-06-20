module SessionsHelper
  def sign_in(user)
    token = SecureRandom.urlsafe_base64
    cookies.permanent[:remember_token] = token
    digest = User.digest(token)
    user.update_attribute(:remember_token, digest)
    self.current_user = user
  end

  def sign_out
    current_user.update_attribute(:remember_token,
              User.digest(SecureRandom.urlsafe_base64))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def signed_in?
    current_user.present?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token( User.digest(cookies[:remember_token]) )
  end
end
