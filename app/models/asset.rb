class Asset < ActiveRecord::Base

	belongs_to :client
	belongs_to :kind
	
end
