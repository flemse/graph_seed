module GraphSeed
  def self.root_path
    Gem::Specification.find_by_name("graph_seed").gem_dir
  end
end
