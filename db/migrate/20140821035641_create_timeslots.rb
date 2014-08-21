class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.string :name, :null=>false
      t.timestamps
    end
    add_index :timeslots, :name
  end
end
