# Users administration

## Features

* [Authentication](spec/feature/authentication_spec.rb)
  * Users can enter profile details including
    * Date of birth using date picker
    * Upload profile picture
  * Admin can be created by running the `db:seed` task from the shell and passing it appropriate environment variables: `ADMIN_EMAIL=<email> ADMIN_PASSWORD=<password> rake db:seed`
* [Authorization](spec/feature/authorization_spec.rb) (users can't visit admin section and Sidekiq web UI, admin can)
* [Admin can](spec/feature/admin_dashboard_spec.rb)
  * List, view, destroy, edit and create normal users
  * Send PDF with selected user's details by Email

## Development

* Use the [Docker development environment](DOCKER.LOCAL.md)
* Run `ADMIN_EMAIL=<email> ADMIN_PASSWORD=<password> rails db:seed` to generate admin user with desired credentials and regular users
