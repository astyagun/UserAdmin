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
  * 3h Profile picture upload and display

# Development

* Use [Docker environment](https://github.com/astyagun/docker-rails-development)
* Use encrypted secrets (`dt rails secrets:edit`) to change `AdminMailer` configuration. The names of keys can be seen in `config/secrets.yml`.
* Run tests with `rspec` (assuming you have aliases described in the link to Docker environment above)

# Deployment

* See `docker-compose.yml` for the list of application dependencies at run time
* Set mailer related options in secrets (preferably encrypted). The names of keys can be seen in `config/secrets.yml`.
* Run `ADMIN_EMAIL=<email> ADMIN_PASSWORD=<password> rails seed` to generate admin user with desired credentials
