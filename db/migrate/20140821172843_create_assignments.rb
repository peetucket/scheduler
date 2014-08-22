class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :asset_id, :null=>false
      t.integer :timeslot_id, :null=>false
      t.integer :remaining, :null=>false, :default=> 0
      t.timestamps
    end
  end
end
