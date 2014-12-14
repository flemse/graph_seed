begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)

load "rails/tasks/engine.rake"

Dir[File.join(File.dirname(__FILE__), "lib/tasks/**/*.rake")].each {|f| load f }

Bundler::GemHelper.install_tasks
require "pry"
begin
  require "rspec/core"
  require "rspec/core/rake_task"

  RSpec::Core::RakeTask.new(:spec)

  task default: ["app:db:setup", :spec]
rescue LoadError
  puts "Error loading rspec"
end

