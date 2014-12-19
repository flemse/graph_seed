module GraphSeed
    class Seeder
    class Relation < Struct.new(:name, :collection?, :polymorphic?); end
    mattr_accessor :ignored_relations, :graph, :errors, :debug, :create_method, :verbose

    attr_accessor :record, :parent

    self.errors = []

    def configure(options = {})
      options.assert_valid_keys(:debug, :max_depth, :ignored, :verbose, :_nested)
      self.debug = options.fetch(:debug, false)
      self.graph = ::GraphSeed::Graph.new max_depth: options[:max_depth]
      self.verbose = options.fetch(:verbose, false)
      self.ignored_relations = options.fetch(:ignored, {})
      self.create_method = :create!
    end

    def initialize(record, options = {})
      configure(options) unless options[:_nested]
      self.parent = parent
      self.record = record
    end

    def to_seed
      puts "Seeding #{var_name}" if self.verbose
      data = []
      if new_record?
        data << "#{var_name} = #{record.class.to_s}.#{create_method.to_s}(#{attributes})"
        add_record
      end

      return data if self.too_deep?
      begin
        relations.each do |r|
          if r.collection?
            record.send(r.name).each do |nr|
              builder = Seeder.new(nr, _nested: true)
              if builder.present? && builder.new_record?
                add_record
                data << builder.to_seed
              end
            end
          elsif r.polymorphic?
          else
            nested_record = record.send(r.name)
            builder = Seeder.new(nested_record, _nested: true) if nested_record.present?
            if builder.present? && builder.new_record?
              add_record
              data << builder.to_seed
            end
          end
        end
      rescue => e
        errors << e
      ensure
        raise errors.first if errors.any?
        return data.flatten
      end
    end

    def new_record?
      graph.new_record?(record)
    end

    def add_record
      graph << record
    end

    def ignored?
      ignored_relations[class_name.to_sym]
    end

    def too_deep?
      graph.too_deep?
    end

    def attributes
      return "" if debug

      @attributes ||= record.serializable_hash
      .except(*%w(id created_at updated_at cmm_ids)).reject do |key, value|
        value.nil?
      end.map do |key, value|
        attribute_map(key, value)
      end.join(", ")
    end

    def attribute_map(key, value)
      key_relation = key_is_relation(key)
      if key_relation
        if key_relation.polymorphic?
          value = "#{record.association(key_relation.name).klass.to_s.downcase}_#{value}"
        else
          value = "#{key_relation.name.to_s}_#{value}"
        end
        "#{key_relation.name.to_s}: #{value}"
      else
        "#{key}: #{attribute_type(value)}"
      end
    end

    def key_is_relation(key)
      relations.select { |r| r.name == key.gsub(/_id$/, "").to_sym }.first
    end

    def attribute_type(value)
      case value
      when Date, DateTime, ActiveSupport::TimeWithZone
        "to_datetime"
      when Integer, Float, Array, TrueClass, FalseClass
        "#{value}"
      else
        "\"#{escape value}\""
      end
    end

    def escape(value)
      value.gsub("\"", "\\\"")
    end

    def var_name
      "#{class_name}_#{record.id}"
    end

    def class_name
      record.class.to_s.gsub("::", "_").downcase
    end

    def relations
      record.class.reflections.values.map do |relation|
        Relation.new(
          relation.name,
          relation.collection?,
          relation.options[:polymorphic] == true
        )
      end.reject do |r|
        ignored_relations[r.name.to_sym] == true
      end
    end
  end
end
