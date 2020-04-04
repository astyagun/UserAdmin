module FeatureAuthenticationHelper
  def log_in(user)
    visit new_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within('.container') { click_on 'Log in' }
  end
end
