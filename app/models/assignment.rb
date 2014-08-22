class Assignment < ActiveRecord::Base

	belongs_to :timeslot
	belongs_to :asset

	validates :timeslot_id, numericality: { only_integer: true } # should validate if its a valid timeslot_id too
	validates :asset_id, numericality: { only_integer: true } # should validate if its a valid asset_id too

	before_create :set_remaining_slots # when we create an assignment, set its total initial capacity

	private 
	def set_remaining_slots
		self.remaining=asset.capacity
	end


end
