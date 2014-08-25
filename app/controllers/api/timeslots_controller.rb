class Api::TimeslotsController < ApplicationController

	def index
		
		date=Date.parse(params[:date]) # sending in bogus dates will explode this, should catch that instead
		
		timeslots=Timeslot.where(:start_timestamp=>date.beginning_of_day..date.end_of_day).includes(:assets) # i heart rails because of stuff like this
		
		render json: timeslots.map {|timeslot| timeslot_output(timeslot)}

	end

	def create
		
		start_time=params[:timeslot][:start_time].to_i # we should do some error checking here to be sure they send in expected formats
		duration=params[:timeslot][:duration]

		timeslot=Timeslot.create(:start_time=>start_time,:duration=>duration) 

		render json: timeslot_output(timeslot)

	end

	private
	# since our output is not a straight model object, but includes some computed methods in the model, lets construct it (probably better if this method was in the model)
	def timeslot_output(timeslot)
	   {:id=>timeslot.id,:start_time=>timeslot.start_time,:duration=>timeslot.duration,:boats=>timeslot.assets.map{|asset| asset.id},:availability=>timeslot.availability,:customer_count=>timeslot.customer_count}
	end


end
