class Client < ActiveRecord::Base

	has_many :assets
	
	attr_accessible :name

	validates :name, :length => { :in => 3..100}

end
