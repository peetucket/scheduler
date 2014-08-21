class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :asset_id, :null=>false
      t.integer :timeslot_id, :null=>false
      t.date :date, :null=>false
      t.integer :tickets, :null=>false
      t.string :ticket_type, :null=>false
      t.text :note
      t.timestamps
    end
  end
end
