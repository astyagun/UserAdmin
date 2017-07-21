require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validity' do
    let(:user) { build :user }
    subject { user.valid? }

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
