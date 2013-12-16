class Employee < ActiveRecord::Base
  has_and_belongs_to_many :units
  scope :active, -> { where(is_active: true) }
  
  def self.not_in_unit(unit_id)
    u = Unit.find unit_id
    active - u.employees
  end
end
