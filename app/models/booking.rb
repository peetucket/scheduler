class Booking < ActiveRecord::Base

	belongs_to :asset
	belongs_to :timeslot

	TICKET_TYPES=%w{regular adult child}

	validates :tickets, numericality: { only_integer: true, greater_than: 0 }
  	validate :check_ticket_types

	before_validation :set_default_ticket_type

	def set_default_ticket_type
		ticket_type='regular' if ticket_type.blank?
	end
	
	def check_ticket_types
       errors.add(:ticket_type, :not_valid) unless TICKET_TYPES.include? ticket_type.to_s
   	end

end
