module Authentication
  class RegisterUser
    include Interactor

    def call
      context.user = User.new context.to_h
      context.fail! unless context.user.save
    end
  end
end
