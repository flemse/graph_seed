module GraphSeed
  class Graph
    attr_accessor :graph, :max_depth
    def initialize(options = {})
      options.assert_valid_keys(:max_depth)
      self.max_depth = options[:max_depth] || Float::INFINITY
      self.graph = {}
    end

    def <<(record)
      graph_position(record) << record.id
    end

    def exists?(record)
      graph_position(record).include?(record.id)
    end

    def new_record?(record)
      !exists?(record)
    end

    def too_deep?
      self.graph.keys.count > self.max_depth
    end

    private

    def graph_position(record)
      self.graph[record_class_name(record)] ||= []
    end

    def record_class_name(record)
      record.class.to_s.gsub("::", "_").downcase.to_sym
    end
  end
end
