class Booking < ActiveRecord::Base

	belongs_to :asset
	belongs_to :timeslot

	attr_accessible :tickets, :note

	validates :tickets, numericality: { only_integer: true }

	TICKET_TYPES=%w{regular adult child}

	before_save :set_default_ticket_type

	def set_default_ticket_type
		ticket_type='regular'
	end

end
