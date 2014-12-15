class Company < ActiveRecord::Base
  has_many :employees
  has_one :settings
end
