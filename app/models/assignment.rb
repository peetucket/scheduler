class Assignment < ActiveRecord::Base

	belongs_to :timeslot
	belongs_to :asset

	validates :timeslot_id, numericality: { only_integer: true } # should validate if its a valid timeslot
	validates :asset_id, numericality: { only_integer: true } # should validate if its a valid asset

end
