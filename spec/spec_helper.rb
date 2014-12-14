ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "database_cleaner"
require "rspec/rails"
require "pry"

Rails.backtrace_cleaner.remove_silencers!
Rails.application.eager_load!

RSpec.configure do |config|
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    Rails.application.load_seed # loading seeds
  end
end

def count_models
  ActiveRecord::Base.descendants.reject do |model|
    model.to_s == "ActiveRecord::SchemaMigration"
  end.map do |model|
    [model.to_s, model.count]
  end
end

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
