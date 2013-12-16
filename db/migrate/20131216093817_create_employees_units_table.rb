class CreateEmployeesUnitsTable < ActiveRecord::Migration
  def change
    create_table :employees_units, id: false do |t|
      t.integer :employee_id
      t.integer :unit_id
    end
  end
end
