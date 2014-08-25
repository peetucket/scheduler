class Booking < ActiveRecord::Base

	belongs_to :timeslot
	has_many :assets, :through=>:timeslot

	TICKET_TYPES=%w{regular adult child} # could have a join table instead if these needed to be dynamic

	validates :tickets, numericality: { only_integer: true, greater_than: 0 }
	validates :timeslot_id, numericality: { only_integer: true } # should validate if its a valid timeslot_id too
  	validate :check_ticket_types
  	validate :confirm_availability

	before_validation :set_default_ticket_type
	before_save :update_timeslot_remaining_slots # before saving the bookings, find capacity on an asset and update the slots left

	def asset
		assets.first
	end

	private
	def update_timeslot_remaining_slots
		# we should have spots remaining by the time we make it to this method, since we are validating availability before allowing the model to save

		# update the number of spots remaining in other assets associated with this timeslot
		assignment=timeslot.assignments.where(['remaining = ?',tickets]).limit(1) # first try and find a slot with the exact number left, provides a small optimization
		if assignment.size == 0 # if we can find any with the exact number of tickets left, just go to the asset with the most spaces left
			assignment=timeslot.assignments.where(['remaining >= ?',tickets]).order('remaining desc').limit(1) # grab the largest possible slot, will explode if we don't have a valid existing timeslot
		end
		assignment.first.remaining -= tickets
		assignment.first.save

		# now find any assets which are now unbookable due to overlapping usage and set their availability to 0
		asset.timeslots.where(['? < end_timestamp AND ? > start_timestamp AND timeslots.id != ?',timeslot.start_timestamp,timeslot.end_timestamp,timeslot.id]).each do |timeslot|
			assignment=asset.assignments.where(:timeslot_id=>timeslot.id)
			assignment.first.remaining = 0
			assignment.first.save
		end

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
