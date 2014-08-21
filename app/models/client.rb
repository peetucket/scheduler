class Client < ActiveRecord::Base

	has_many :assets
	
	validates :name, presence: true

end
