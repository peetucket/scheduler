class Booking < ActiveRecord::Base

	belongs_to :asset
	belongs_to :timeslot

	TICKET_TYPES=%w{regular adult child} # could have a join table instead if these needed to be dynamic

	validates :tickets, numericality: { only_integer: true, greater_than: 0 }
 	validates :asset_id, numericality: { only_integer: true }
	validates :timeslot_id, numericality: { only_integer: true }
  	validate :check_ticket_types

	before_validation :set_default_ticket_type

	def set_default_ticket_type
		ticket_type=Scheduler::Application.config.default_ticket_type if ticket_type.blank?
	end
	
	def check_ticket_types
       errors.add(:ticket_type, :not_valid) unless TICKET_TYPES.include? ticket_type.to_s
   	end

end
