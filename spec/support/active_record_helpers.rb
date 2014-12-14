def count_models
  ActiveRecord::Base.descendants.reject do |model|
    model.to_s == "ActiveRecord::SchemaMigration"
  end.map do |model|
    [model.to_s, model.count]
  end
end
