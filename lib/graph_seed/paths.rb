module GraphSeed
  attr_writer :seed_path

  def self.root_path
    Gem::Specification.find_by_name("graph_seed").gem_dir
  end

  def self.seed_path
    @seed_path ||= ""
  end

end
