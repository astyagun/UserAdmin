require 'rails_helper'

RSpec.describe 'Root path', type: :request do
  subject { get '/' }

  it { is_expected.to eq 302 }
  it { is_expected.to redirect_to new_session_path }
end
