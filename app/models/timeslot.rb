class Timeslot < ActiveRecord::Base

	validates :start_time, numericality: { only_integer: true } # should really validate if its a valid unix timestamp
    validates :duration, numericality: { only_integer: true, greater_than: 0 }
    
    has_many :assets, :through => :assignments
    has_many :assignments
    has_many :bookings

    before_save :set_start_timestamp

    # we may want to cache these computed values to make things quicker, and then just recompute for each new booking or assignment

    # total availability across all assets at this timeslot
    def total_availability
    	total_capacity - customer_count
    end

    # largest available single block on any single asset at this timeslot
    def availability
        assignments.maximum(:remaining) # sql computation
    end
 
 	# total capacity across all assets at this timeslot
    def total_capacity
    	assets.sum(:capacity) # sql computation
    end

    # total customer count across all assets at this timeslot
    def customer_count
    	bookings.sum(:tickets) # sql computation
    end

    private
    def set_start_timestamp
      self.start_timestamp=Time.at(start_time).to_datetime # convert start time in Unix timestamp to a regular timestamp for storage in database for easier querying
    end

end
