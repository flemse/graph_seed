class Project < ActiveRecord::Base
  belongs_to :employee
  has_many :tasks
end

