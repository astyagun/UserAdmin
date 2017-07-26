require 'rails_helper'

RSpec.describe 'Authentication', type: :feature do
  describe 'registration' do
    let(:user_attributes) { attributes_for :user }
    subject do
      visit root_path
      within('.navbar') { click_on 'Register' }

      fill_in 'Email', with: user_attributes[:email]
      fill_in 'Password', with: user_attributes[:password], match: :prefer_exact
      fill_in 'Password confirmation', with: user_attributes[:password], match: :prefer_exact
      fill_in 'Full name', with: user_attributes[:full_name]
      fill_in 'Birth date', with: user_attributes[:birth_date]
      fill_in 'Small biography', with: user_attributes[:small_biography]
      within('.content') { click_on 'Register' }
    end

    it 'registers user' do
      subject

      expect(page).to have_content 'Registration was successful'
      within('h1') { expect(page).to have_content 'Log in' }
    end

    context 'when invalid data is entered' do
      before { user_attributes.delete :full_name }

      it 'displays error message' do
        subject

        expect(page).to have_content 'Error performing registration'
        within('h1') { expect(page).to have_content 'Register' }
      end
    end
  end

  describe 'logging in and loggin out' do
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
        within('.content') { click_on 'Log in' }

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
          within('.content') { click_on 'Log in' }

          expect(page).to have_content 'Incorrect email or password'
        end
      end
    end
  end

  describe 'visiting admin section' do
    subject { visit admin_root_path }

    context 'when user is not logged in' do
      it 'redirects to log in page and renders a flash message' do
        subject

        expect(page).to have_content 'Please log in first'
        within('h1') { expect(page).to have_content 'Log in' }
      end
    end

    context 'when logged in as user' do
      before { log_in create :user }

      it 'redirects to home page and renders a flash message' do
        subject

        expect(page).to have_content 'Please log in as administrator to access that page'
        within('h1') { expect(page).to have_content 'Welcome' }
      end
    end

    context 'when logged in as admin' do
      before { log_in create(:user, :admin) }

      it 'renders admin section' do
        subject
        within('h1') { expect(page).to have_content 'Users' }
      end
    end
  end

  describe 'visiting home page' do
    subject { visit home_path }

    context 'when user is not logged in' do
      it 'redirects to log in page and renders a flash message' do
        subject

        expect(page).to have_content 'Please log in first'
        within('h1') { expect(page).to have_content 'Log in' }
      end
    end
  end
end
