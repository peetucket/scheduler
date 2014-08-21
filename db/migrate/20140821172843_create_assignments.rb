class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :asset_id
      t.integer :timeslot_id
      t.timestamps
    end
  end
end
