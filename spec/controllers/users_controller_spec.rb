require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#new' do
    subject { get :new }

    it 'sets user instance variable' do
      expect { subject }.to change { assigns(:user).class }.from(NilClass).to(User)
      expect(assigns(:user)).to be_new_record
    end

    it 'sets user instance variable' do
      expect { subject }.to change { assigns(:user) }.from(nil).to(an_instance_of(User))
    end

    it { is_expected.to render_template :new }
  end

  describe '#create' do
    before { allow(Authentication::Register).to receive(:call).and_return(registration_result) }
    let(:registration_result) { double success?: true }
    let(:user) { build :user }
    subject { post :create, params: {user: user.attributes} }

    it 'sets flash notice' do
      expect { subject }.to change { flash.notice }.from(nil).to('Registration was successful')
    end

    it { is_expected.to redirect_to new_session_path }

    context 'when failed to create user' do
      let(:registration_result) { double success?: false, user: user }

      it 'sets user instance variable' do
        expect { subject }.to change { assigns(:user) }.from(nil).to(user)
      end

      it 'sets immediate flash alert' do
        expect { subject }.to change { flash.now[:alert] }.from(nil).to('Error performing registration')
      end

      it { is_expected.to render_template :new }
    end
  end
end
