require "active_support"

module GraphSeed
  class Seeder
    class Relation < Struct.new(:name, :collection?, :polymorphic?); end
    mattr_accessor :current_depth, :max_depth, :ignored_relations, :graph, :errors, :debug
    attr_accessor :record, :parent

    self.current_depth = 0
    self.graph = {}
    self.errors = []

    def configure(options = {})
      options.assert_valid_keys(:debug, :max_depth, :ignored, :parent)
      self.debug = options[:debug] || false
      self.max_depth = options[:max_depth] || Float::INFINITY
      self.current_depth = 0
      self.graph = {}
      self.ignored_relations = options[:ignored] || {}
    end

    def initialize(record, options = {})
      configure(options) unless options[:parent]
      self.parent = parent
      self.record = record
      self.graph[class_name.to_sym] ||= []
    end

    def to_seed
      data = []
      if new_record?
        data << "#{var_name} = #{record.class.to_s}.create(#{attributes})"
        add_record
      end

      return data if self.too_deep?
      begin
        relations.each do |r|
          if r.collection?
            record.send(r.name).each do |nr|
              builder = Seeder.new(nr, parent: self)
              if builder.present? && builder.new_record?
                add_record
                data << builder.to_seed
              end
            end
          elsif r.polymorphic?
          else
            nested_record = record.send(r.name)
            builder = Seeder.new(nested_record, parent: self) if nested_record.present?
            if builder.present? && builder.new_record?
              add_record
              data << builder.to_seed
            end
          end
        end
      rescue => e
        errors << e
      ensure
        return data.flatten
      end
    end

    def new_record?
      !self.graph[class_name.to_sym].include?(record.id)
    end

    def add_record
      self.graph[class_name.to_sym] << record.id
    end

    def ignored?
      ignored_relations[class_name.to_sym]
    end

    def too_deep?
      current_depth = self.current_depth
      self.current_depth += 1

      self.max_depth < current_depth
    end

    def attributes
      return "" if debug

      @attributes ||= record.serializable_hash
      .except(*%w(id created_at updated_at cmm_ids))
      .map do |key, value|
        "#{key}: #{attribute_type(value)}"
      end.join(", ")
    end

    def attribute_type(value)
      case value
      when Date, DateTime, ActiveSupport::TimeWithZone
        "to_datetime"
      when Integer
        "#{value}"
      else
        "\"#{value}\""
      end
    end

    def var_name
      "#{class_name}_#{record.id}"
    end

    def class_name
      record.class.to_s.gsub("::", "_").downcase
    end

    def relations
      record.class.reflections.values.map do |relation|
        Relation.new(relation.name, relation.collection?, relation.options[:polymorphic] == true)
      end.reject do |r|
        ignored_relations[r.name.to_sym] == true
      end
    end

    def record
      @record
    end
  end
end
