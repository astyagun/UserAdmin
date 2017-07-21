module Authentication
  class Check
    include Interactor

    def call
      user = User.find_by(email: context.email)

      if user && user.authenticate(context.password)
        context.user = user
      else
        context.fail! message: I18n.t('interactors.authentication.check.failure')
      end
    end
  end
end
