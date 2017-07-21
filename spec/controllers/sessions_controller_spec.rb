require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
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
      before { allow(authentication_check_result).to receive_messages(success?: false, error: 'Error') }

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
end
