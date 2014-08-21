class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :kind, :null=>false
      t.integer :client_id, :null=>false
      t.integer :availability, :null=>false, :default=>0
      t.timestamps
    end
  end
end
