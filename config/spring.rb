%w[
  .rbenv-vars
  .ruby-version
  app/middleware/auth_base_middleware.rb
  app/middleware/authentication_middleware.rb
  app/middleware/authorization_middleware.rb
  app/middleware/concerns/controller_compatibility_concern.rb
  config/initializers/simple_form.rb
  config/initializers/simple_form_bootstrap.rb
  config/routes.rb
  tmp/caching-dev.txt
  tmp/restart.txt
].each { |path| Spring.watch(path) }
