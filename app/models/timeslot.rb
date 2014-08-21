class Timeslot < ActiveRecord::Base

	validates :start_time, :presence=>true
    validates :duration, numericality: { only_integer: true, greater_than: 0 }
    
    has_many :assets, :through => :assignments
    has_many :assignments

end
