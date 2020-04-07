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
  * Send PDF with selected user's details by Email. Destination Email address is set in secrets file using:

    ```yaml
    <environment>:
      admin_mailer:
        to: <recipient@example.com>
    ```

## Development

Use the [Docker development environment](DOCKER.LOCAL.md)

## Deployment

* See `docker-compose.yml` for the list of application dependencies at run time
* Generate a Rails master key: `dkce -e RAILS_MASTER_KEY= spring rake secret > config/secrets.yml.key`
* For the Production environment
  * Set mailer related options in encrypted secrets. The names of keys can be found in `config/secrets.yml`.
  * Set `secret_key_base` in encrypted secrets (`rails secrets:edit`)
* Run `ADMIN_EMAIL=<email> ADMIN_PASSWORD=<password> rails db:seed` to generate admin user with desired credentials
