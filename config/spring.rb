%w[
  .rbenv-vars
  .ruby-version
  app/middleware/authentication_middleware.rb
  config/initializers/simple_form.rb
  config/initializers/simple_form_bootstrap.rb
  config/routes.rb
  tmp/caching-dev.txt
  tmp/restart.txt
].each { |path| Spring.watch(path) }
