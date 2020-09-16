# Load the Rails application.
require_relative 'application'
require 'ipinfo-rails'

Rails.application.middleware.use(IPinfoMiddleware, {token: ENV['URL_PREFIX']})

# Initialize the Rails application.
Rails.application.initialize!
