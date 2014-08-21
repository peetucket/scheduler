class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :timeslot_id, :null=>false
      t.integer :tickets, :null=>false
      t.string :ticket_type, :null=>false
      t.text :note
      t.timestamps
    end
  end
end
