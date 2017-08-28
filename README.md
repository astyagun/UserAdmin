Users administration
====================

# Features

  * Authentication
    * Users can enter profile details including
      * Date of birth using date picker
      * Upload profile picture
    * Admin can be created by running the `db:seed` task from the shell and passing it appropriate environment variables: `ADMIN_EMAIL=<email> ADMIN_PASSWORD=<password> rake db:seed`
  * Authorization (users can't visit admin section and Sidekiq web UI, admin can)
  * Admin can
    * List, view, destroy, edit and create normal users
    * Send PDF with selected user's details by Email. Destination Email address is set in secrets file using:
      ```yaml
      <environment>:
        admin_mailer:
          to: <recipient@example.com>
      ```

# Development

* Use [Docker environment](https://github.com/astyagun/docker-rails-development)
* Use encrypted secrets (`dt rails secrets:edit`) to change `AdminMailer` configuration. The names of keys can be found in `config/secrets.yml`.
* Run tests with `rspec` (assuming you have shell aliases, which are described in the link to Docker environment above)

# Deployment

* See `docker-compose.yml` for the list of application dependencies at run time
* Set mailer related options in encrypted secrets. The names of keys can be found in `config/secrets.yml`.
* Set `secret_key_base` in encrypted secrets
* Run `ADMIN_EMAIL=<email> ADMIN_PASSWORD=<password> rails seed` to generate admin user with desired credentials
