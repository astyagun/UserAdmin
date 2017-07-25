%w(
  .ruby-version
  .rbenv-vars
  tmp/restart.txt
  tmp/caching-dev.txt
  config/initializers/simple_form.rb
  config/initializers/simple_form_bootstrap.rb
).each { |path| Spring.watch(path) }
