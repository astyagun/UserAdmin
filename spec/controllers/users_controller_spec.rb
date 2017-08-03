require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#new' do
    subject(:controller_action) { get :new }

    it 'sets user instance variable', :aggregate_failures do
      expect { controller_action }.to change { assigns(:user) }.from(nil).to(an_instance_of(User))
      expect(assigns(:user)).to be_new_record
    end

    it { is_expected.to render_template :new }
  end

  describe '#create' do
    subject(:controller_action) { post :create, params: {user: user_attributes} }

    before { allow(register_user_interactor).to receive(:call).and_return(registration_result) }
    let(:register_user_interactor) { class_double(Authentication::RegisterUser).as_stubbed_const }
    let(:registration_result) { instance_double Interactor::Context, success?: true }
    let(:user_attributes) { attributes_for :user, :admin }

    it 'sets flash notice' do
      expect { controller_action }.to change { flash.notice }.from(nil).to('Registration was successful')
    end

    it { is_expected.to redirect_to new_session_path }

    it 'does not pass role param to the interactor' do
      controller_action
      expect(register_user_interactor).to have_received(:call).with(hash_not_including(:role))
    end

    context 'when failed to create user' do
      let(:user) { User.new user_attributes }
      let(:registration_result) { double success?: false, user: user } # rubocop:disable RSpec/VerifiedDoubles

      it 'sets user instance variable' do
        expect { controller_action }.to change { assigns(:user) }.from(nil).to(user)
      end

      it 'sets immediate flash alert' do
        expect { controller_action }.to change { flash.now[:alert] }.
          from(nil).to('Error performing registration')
      end

      it { is_expected.to render_template :new }
    end
  end
end
