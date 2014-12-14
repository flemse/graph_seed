require "active_support"
require "graph_seed/paths"
require "graph_seed/seeder"

module GraphSeed

  def self.load_tasks
    Dir[File.expand_path("tasks/*.rake", File.dirname(__FILE__))].each { |ext| load ext }
  end

  require "graph_seed/railie" if defined?(Rails) && Rails::VERSION::MAJOR >= 3
end
