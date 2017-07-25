require 'rails_helper'

# Using type: :request to be able to test a redirect
RSpec.describe 'Root path', type: :request do
  subject { get '/' }
  it { is_expected.to redirect_to new_session_path }
end
