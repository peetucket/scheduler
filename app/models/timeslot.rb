class Timeslot < ActiveRecord::Base

	validates :name, presence: true
    validates :duration, numericality: { only_integer: true, :greater_than: 0 }

end
