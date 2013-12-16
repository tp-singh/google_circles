class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.integer :circle_id

      t.timestamps
    end
  end
end
