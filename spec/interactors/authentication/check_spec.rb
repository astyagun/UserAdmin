require 'rails_helper'

RSpec.describe Authentication::Check do
  describe '.call' do
    subject { described_class.call email: email, password: password }

    let(:user) { create :user }
    let(:email) { user.email }
    let(:password) { user.password }

    it { is_expected.to be_success }

    it 'returns the user' do
      expect(subject.user).to eq user
    end

    context 'when there is no user for email provided' do
      let(:email) { '123' }

      it { is_expected.not_to be_success }

      it 'returns an error message' do
        expect(subject.message).to eq 'Incorrect email or password'
      end
    end

    context 'when incorrect password is given' do
      let(:password) { user.password + '123' }

      it { is_expected.not_to be_success }

      it 'returns an error message' do
        expect(subject.message).to eq 'Incorrect email or password'
      end
    end
  end
end
