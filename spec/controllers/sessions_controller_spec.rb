require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe '#new' do
    subject { get :new }

    it { is_expected.to render_template :new }

    context 'when user is already logged in' do
      before { session[:user_id] = user.id }
      let(:role) { 'user' }
      let(:user) { create :user, role: role }

      it { is_expected.to redirect_to home_path }

      context 'and user role is admin' do
        let(:role) { 'admin' }

        it { is_expected.to redirect_to admin_users_path }
      end
    end

    context 'when session has :user_id of unexistent user' do
      before { session[:user_id] = 1 }

      it 'clears session[:user_id]' do
        expect { subject }.to change { session[:user_id] }.from(1).to(nil)
      end

      it { is_expected.to redirect_to new_session_path }

      it 'sets flash message' do
        expect { subject }.to change { flash.notice }.from(nil).to('Logged out successfully')
      end
    end
  end

  describe '#create' do
    before { allow(Authentication::Check).to receive(:call).and_return(authentication_check_result) }
    let(:authentication_check_result) { double success?: true, user: user }
    let(:user_role) { 'admin' }
    let(:user) { build_stubbed :user, role: user_role }
    let(:params) { {'session' => user.attributes.slice('email', 'password')} }
    subject { post :create, params: params }

    it 'saves user.id to session' do
      expect { subject }.to change { session[:user_id] }.from(nil).to(user.id)
    end

    it 'sets flash notice message' do
      expect { subject }.to change { flash.notice }.from(nil).to('Logged in successfully')
    end

    it 'redirects to admin dashboard' do
      expect(subject).to redirect_to admin_users_path
    end

    context 'when user role is "user"' do
      let(:user_role) { 'user' }

      it 'saves user.id to session' do
        expect { subject }.to change { session[:user_id] }.from(nil).to(user.id)
      end

      it 'sets flash notice message' do
        expect { subject }.to change { flash.notice }.from(nil).to('Logged in successfully')
      end

      it 'redirects to admin dashboard' do
        expect(subject).to redirect_to home_path
      end
    end

    context 'when authentication is unsuccessful' do
      before { allow(authentication_check_result).to receive_messages(success?: false, message: 'Error') }

      it 'does not change session[:user_id]' do
        expect { subject }.not_to change { session[:user_id] }.from(nil)
      end

      it 'sets flash.now alert message' do
        expect { subject }.to change { flash.now[:alert] }.from(nil).to('Error')
      end

      it 'renders the same template' do
        expect(subject).to render_template :new
      end
    end
  end

  describe '#destroy' do
    before { session[:user_id] = user.id }
    let(:user) { create :user }
    subject { delete :destroy }

    it 'clears session[:user_id]' do
      expect { subject }.to change { session[:user_id] }.from(user.id).to(nil)
    end

    it { is_expected.to redirect_to new_session_path }

    it 'sets flash message' do
      expect { subject }.to change { flash.notice }.from(nil).to('Logged out successfully')
    end

    context 'when user is not logged in' do
      before { session.delete :user_id }

      it 'clears session[:user_id]' do
        expect { subject }.not_to change { session[:user_id] }.from(nil)
      end

      it { is_expected.to redirect_to new_session_path }

      it 'sets flash message' do
        expect { subject }.to change { flash.notice }.from(nil).to('Logged out successfully')
      end
    end
  end
end
