require 'bundler/setup'
Bundler.require(:default, :development)


ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite"
)

require_all 'app'
