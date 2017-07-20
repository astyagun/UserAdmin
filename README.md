Users administration
====================

Estimation: 16h - 32h

  * Install
    * 1h
      * Docker
      * Rails
      * Redis
      * Sidekiq
    * 30m
      * RSpec
      * Capybara
      * Factory girl
    * 30m Bootstrap
  * 2h Admin can list, view, destroy, edit and create normal users
  * 30m Generate User model
    * role (default: 'user')
    * email
    * full name
    * birth date
    * small biography
    * profile picture (optional)
  * 30m Add validations and a factory for User model
  * Seed admin
  * Authentication
    * 2h Registration
    * 1h Login
      * Redirect user to Welcome page
      * Redirect admin to User list
  * 1h Authorization
  * 3h Create PDF
  * 1h Send PDF by Email (should be possible to send it to [development@taskwunder.com](mailto:development@taskwunder.com) when needed)
  * 3h Profile picture upload and display
