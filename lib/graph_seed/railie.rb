require "graph_seed"
require "rails"

module GraphSeed
  class Railie < Rails::Railtie
    rake_tasks do
      File.expand_path("db/seeds", Rails.root)
      GraphSeed.load_tasks
    end
  end
end
