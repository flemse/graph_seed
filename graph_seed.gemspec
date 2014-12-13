$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "graph_seed/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "graph_seed"
  s.version     = GraphSeed::VERSION
  s.authors     = ["Flemming Thesbjerg"]
  s.email       = ["flemming.thesbjerg@gmail.com"]
  s.homepage    = "https://github.com/flemse/graph_seed"
  s.summary     = "Create seed data from existing database"
  s.description = "Create seed data from existing database with connected objects"
  s.license     = "MIT"

  s.files = Dir["{spec,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rails"
  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "pry"
end
