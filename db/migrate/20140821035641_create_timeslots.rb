class CreateTimeslots < ActiveRecord::Migration
  def change
    create_table :timeslots do |t|
      t.string :name, :null=>false
      t.date :date
      t.time :start_time
      t.integer :duration, :null=>false, :default=>0
      t.timestamps
    end
  end
end
