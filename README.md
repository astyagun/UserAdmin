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
  * 30m Generate User model
    * role (default: 'user')
    * email
    * full name
    * birth date
    * small biography
    * profile picture (optional)
  * 30m Add validations and a factory for User model
  * 30m Install Bootstrap
  * Authentication
    * 2h Registration
    * 1h Login
      * Redirect user to Welcome page
      * Redirect admin to User list
  * Seed admin
  * 2h Admin can list, view, destroy, edit and create normal users
  * 1h Authorization
  * 3h Create PDF
  * 1h Send PDF by Email (should be possible to send it to [development@taskwunder.com](mailto:development@taskwunder.com) when needed)
* * *
  * 3h Profile picture upload and display

# Development

* Use [Docker environment](https://github.com/astyagun/docker-rails-development)
* Use encrypted secrets (`dt rails secrets:edit`) to change `AdminMailer` configuration

TODO

Overwrite

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
