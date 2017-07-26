# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  # http://localhost:3000/rails/mailers/admin_mailer/user_details
  def user_details
    AdminMailer.user_details User.first
  end
end
