module GraphSeed
  class Graph
    attr_accessor :graph, :max_depth
    def initialize(options = {})
      self.max_depth = options[:max_depth] || Float::INFINITY
      self.depth = 0
    end

    def <<(record)
      self.graph[record_class_name(record)] ||= [] << record
    end

    def exists?(record)
      self.graph[record_class_name(record)].include?(record.id)
    end

    def new_record?(record)
      !exists?(record)
    end

    def too_deep?
      self.graph.keys.count > self.max_depth
    end

    private
    def record_class_name(record)
      record.class.to_s.gsub("::", "_").downcase.to_sym
    end
  end
end
