require 'rails_helper'

RSpec.describe 'Authentication', type: :system do
  describe 'registration' do
    subject :register do
      visit root_path
      within('.navbar') { click_on 'Register' }

      fill_in 'Email', with: user_attributes[:email]
      fill_in 'Password', with: user_attributes[:password], match: :prefer_exact
      fill_in 'Password confirmation', with: user_attributes[:password], match: :prefer_exact
      fill_in 'Full name', with: user_attributes[:full_name]
      fill_in 'Birth date', with: user_attributes[:birth_date]
      fill_in 'Small biography', with: user_attributes[:small_biography]
      attach_file 'Avatar', Rails.root.join('spec/files/avatar.jpg')

      within('.container') { click_on 'Register' }
    end

    let(:user_attributes) { attributes_for :user }

    it 'registers a new user' do
      expect { register }.to change(User, :count).by 1

      expect(page).to have_content 'Registration was successful'
      within('h1') { expect(page).to have_content 'Log in' }

      new_user = User.last
      expect(new_user).to have_attributes user_attributes.except(:password, :password_confirmation)
      expect(new_user.avatar.url).to match(/avatar\.jpg/)
    end

    context 'when invalid data is entered' do
      before { user_attributes.delete :full_name }

      it 'displays error message' do
        register

        expect(page).to have_content 'Error performing registration'
        within('h1') { expect(page).to have_content 'Register' }
      end
    end
  end

  describe 'logging in and logging out' do
    let(:user) { create :user, role: role }

    context 'when user role is admin' do
      let(:role) { 'admin' }

      it 'logs user in and out' do
        log_in user

        expect(page).to have_content 'Logged in successfully'
        within('h1') { expect(page).to have_content 'Users' }

        within('.navigation') { click_on 'Log out' }

        expect(page).to have_content 'Logged out successfully'
        within('h1') { expect(page).to have_content 'Log in' }
      end
    end

    context 'when user role is user' do
      let(:role) { 'user' }

      it 'logs user in and out' do
        visit new_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        within('.container') { click_on 'Log in' }

        expect(page).to have_content 'Logged in successfully'
        expect(page).to have_content 'Welcome'

        within('.navbar') { click_on 'Log out' }

        expect(page).to have_content 'Logged out successfully'
        within('h1') { expect(page).to have_content 'Log in' }
      end

      context 'and incorrect credentials are entered' do
        it 'displays error message' do
          visit new_session_path
          fill_in 'Email', with: user.email + '123'
          fill_in 'Password', with: user.password
          within('.container') { click_on 'Log in' }

          expect(page).to have_content 'Incorrect email or password'
        end
      end
    end
  end
end
