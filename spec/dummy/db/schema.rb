ActiveRecord::Schema.define(version: 1) do

  create_table :companies, force: true do |t|
    t.string :name
  end

  create_table :employees, force: true do |t|
    t.integer :company_id
    t.string :lucky_numbers
    t.string  :name
    t.boolean :admin
    t.text :comment
  end

  create_table :projects, force: true do |t|
    t.integer :employee_id
    t.integer :field_with_stupid_name_id
    t.string  :name
  end

  create_table :tasks, force: true do |t|
    t.integer :project_id
    t.string :name
  end

  create_table :settings, force: true do |t|
    t.integer :company_id
  end

end
