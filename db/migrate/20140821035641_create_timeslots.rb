class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.datetime :start_time, :null=>false
      t.integer :duration, :null=>false, :default=>0
      t.timestamps
    end
  end
end
