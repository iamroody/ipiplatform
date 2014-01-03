require 'cucumber/rails'
require 'capybara/poltergeist'

Capybara.javascript_driver = :poltergeist
#Capybara.default_driver = :selenium #uncomment this to use selenium

require File.join(Rails.root, 'features', 'pages', 'page')
ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Cucumber::Rails::Database.javascript_strategy = :truncation

