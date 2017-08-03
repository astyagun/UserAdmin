class ApplicationController < ActionController::Base
  include AuthenticationConcern
  include AuthorizationConcern
  protect_from_forgery with: :exception
end
