class Assignment < ActiveRecord::Base

	belongs_to :timeslot
	belongs_to :asset

end
