class Booking < ActiveRecord::Base

	belongs_to :timeslot

	TICKET_TYPES=%w{regular adult child} # could have a join table instead if these needed to be dynamic

	validates :tickets, numericality: { only_integer: true, greater_than: 0 }
	validates :timeslot_id, numericality: { only_integer: true } # should validate if its a valid timeslot_id too
  	validate :check_ticket_types
  	validate :confirm_availability

	before_validation :set_default_ticket_type
	before_save :update_timeslot_remaining_slots

	private
	def update_timeslot_remaining_slots
		assignment=timeslot.assignments.where(['remaining >= ?',tickets]).order('remaining desc').limit(1).first # grab the largest possible slot, will explode if we don't have a valid existing timeslot
		assignment.remaining -= tickets
		assignment.save
	end

	def set_default_ticket_type
		self.ticket_type=Scheduler::Application.config.default_ticket_type if ticket_type.blank?
	end
	
	def confirm_availability
		errors.add(:base,'no availability') if timeslot && tickets && timeslot.availability < tickets
	end

	def check_ticket_types
       errors.add(:ticket_type, :not_valid) unless TICKET_TYPES.include? ticket_type.to_s
   	end

end
