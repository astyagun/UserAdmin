class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.smtp[:from]
end
