class ApplicationController < ActionController::Base
  include AuthenticationMethods
  protect_from_forgery with: :exception
end
