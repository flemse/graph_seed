class Company < ActiveRecord::Base
  has_many :employees
  has_many :tags, as: :tagable
  has_one :settings
end
