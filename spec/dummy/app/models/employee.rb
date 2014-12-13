class Employee < ActiveRecord::Base
  belongs_to :company
  has_many :projects
end
