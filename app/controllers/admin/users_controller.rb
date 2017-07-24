module Admin
  class UsersController < ApplicationController
    def index
      flash.now.notice = 'Test'
    end
  end
end
