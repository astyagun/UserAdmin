Users administration
====================

# Development

* Use [Docker environment](https://github.com/astyagun/docker-rails-development)
* Use encrypted secrets (`dt rails secrets:edit`) to change `AdminMailer` configuration. The names of keys can be seen in `config/secrets.yml`.
* Run tests with `rspec` (assuming you have aliases described in the link to Docker environment above)

# Deployment

* See `docker-compose.yml` for the list of application dependencies at run time
* Set mailer related options in secrets (preferably encrypted). The names of keys can be seen in `config/secrets.yml`.
* Set `secret_key_base` in encrypted secrets
* Run `ADMIN_EMAIL=<email> ADMIN_PASSWORD=<password> rails seed` to generate admin user with desired credentials
