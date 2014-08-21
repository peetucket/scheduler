class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, :null=>false
      t.boolean :active, :null=>false, :default=>true
      t.timestamps
    end
    Client.create(:name=>'Piranha View')
  end
end
