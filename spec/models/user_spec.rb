require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validity' do
    subject { user.valid? }

    let(:user) { build :user }

    it { is_expected.to be true }

    %i[role email full_name birth_date small_biography].each do |field|
      context "when ##{field} is nil" do
        before { user[field] = nil }

        it { is_expected.to be false }
      end

      context "when ##{field} is and empty string" do
        before { user[field] = '' }

        it { is_expected.to be false }
      end
    end

    context 'when #role is manager' do
      before { user.role = 'manager' }

      it { is_expected.to be false }
    end

    context 'when #email is 123' do
      before { user.email = 123 }

      it { is_expected.to be false }
    end

    context 'when #email is email' do
      before { user.email = 'email' }

      it { is_expected.to be false }
    end

    context 'when #email is email@domain' do
      before { user.email = 'email@domain' }

      it { is_expected.to be false }
    end

    context 'when user with the same email already exists' do
      before { create :user, email: user.email }

      it { is_expected.to be false }
    end

    context 'when password is changed' do
      before { user.assign_attributes password: password, password_confirmation: password_confirmation }

      let(:password) { '12345678' }
      let(:password_confirmation) { password }

      it { is_expected.to be true }

      context 'when changed to nil' do
        let(:password) { nil }

        it { is_expected.to be false }
      end

      context 'when changed to an empty string' do
        let(:password) { '' }

        it { is_expected.to be false }
      end

      context 'when changed to a string 7 characters long' do
        let(:password) { '1234567' }

        it { is_expected.to be false }
      end

      context 'and password_confirmation does not match it' do
        let(:password_confirmation) { '123' }

        it { is_expected.to be false }
      end
    end

    context 'when password is not changed (but some other field is changed)' do
      before { user.small_biography = '123' }

      let(:user) { described_class.find create(:user).id }

      it { is_expected.to be true }
    end
  end

  describe 'factory' do
    subject { build :user }

    it { is_expected.to be_valid }

    describe 'admin trait' do
      subject { build :user, :admin }

      it { is_expected.to be_valid }
    end
  end
end
