class ApplicationController < ActionController::Base
  include AuthenticationControllerMethods
  protect_from_forgery with: :exception
end
