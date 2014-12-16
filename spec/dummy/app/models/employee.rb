class Employee < ActiveRecord::Base
  belongs_to :company

  has_many :tags, as: :tagable
  has_many :projects

  serialize :lucky_numbers
end
