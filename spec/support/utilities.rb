def sign_in(user, options = {})
  if options[:no_capybara]
    token = SecureRandom.urlsafe_base64
    cookies[:remember_token] = token
    user.update_attribute(:remember_token, User.digest(token))
  else
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.Password
    click_button "Sign in"
  end
end
