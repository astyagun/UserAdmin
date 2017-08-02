require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#new' do
    subject(:controller_action) { get :new }

    it { is_expected.to render_template :new }

    context 'when user is already logged in' do
      before { log_in user }
      let(:role) { 'user' }
      let(:user) { create :user, role: role }

      it { is_expected.to redirect_to home_path }

      context 'and user role is admin' do # rubocop:disable RSpec/NestedGroups
        let(:role) { 'admin' }

        it { is_expected.to redirect_to admin_users_path }
      end
    end

    context 'when session has :user_id of unexistent user' do
      before { log_in User.new(id: 1) }

      it 'clears session[:user_id]' do
        expect { controller_action }.to change { session[:user_id] }.from(1).to(nil)
      end

      it { is_expected.to redirect_to new_session_path }

      it 'sets flash message' do
        expect { controller_action }.to change { flash.notice }.from(nil).to('Logged out successfully')
      end
    end
  end

  describe '#create' do
    subject(:controller_action) { post :create, params: params }

    before { allow(Authentication::Check).to receive(:call).and_return(authentication_check_result) }
    let :authentication_check_result do
      double success?: true, user: user # rubocop:disable RSpec/VerifiedDoubles
    end
    let(:user_role) { 'admin' }
    let(:user) { build_stubbed :user, role: user_role }
    let(:params) { {'session' => user.attributes.slice('email', 'password')} }

    it 'saves user.id to session' do
      expect { controller_action }.to change { session[:user_id] }.from(nil).to(user.id)
    end

    it 'sets flash notice message' do
      expect { controller_action }.to change { flash.notice }.from(nil).to('Logged in successfully')
    end

    it 'redirects to admin dashboard' do
      expect(controller_action).to redirect_to admin_users_path
    end

    context 'when user role is "user"' do
      let(:user_role) { 'user' }

      it 'saves user.id to session' do
        expect { controller_action }.to change { session[:user_id] }.from(nil).to(user.id)
      end

      it 'sets flash notice message' do
        expect { controller_action }.to change { flash.notice }.from(nil).to('Logged in successfully')
      end

      it 'redirects to admin dashboard' do
        expect(controller_action).to redirect_to home_path
      end
    end

    context 'when authentication is unsuccessful' do
      before { allow(authentication_check_result).to receive_messages(success?: false, message: 'Error') }

      it 'does not change session[:user_id]' do
        expect { controller_action }.not_to change { session[:user_id] }.from(nil)
      end

      it 'sets flash.now alert message' do
        expect { controller_action }.to change { flash.now[:alert] }.from(nil).to('Error')
      end

      it 'renders the same template' do
        expect(controller_action).to render_template :new
      end
    end
  end

  describe '#destroy' do
    subject(:controller_action) { delete :destroy }

    before { log_in User.new(id: 1) }

    it 'clears session[:user_id]' do
      expect { controller_action }.to change { session[:user_id] }.from(1).to(nil)
    end

    it { is_expected.to redirect_to new_session_path }

    it 'sets flash message' do
      expect { controller_action }.to change { flash.notice }.from(nil).to('Logged out successfully')
    end

    context 'when user is not logged in' do
      before { log_out }

      it 'clears session[:user_id]' do
        expect { controller_action }.not_to change { session[:user_id] }.from(nil)
      end

      it { is_expected.to redirect_to new_session_path }

      it 'sets flash message' do
        expect { controller_action }.to change { flash.notice }.from(nil).to('Logged out successfully')
      end
    end
  end
end
