class Api::TimeslotsController < ApplicationController

	def index
		
		date=Date.parse(params[:date]) # sending in bogus dates will explode this, should catch that instead
		
		timeslots=Timeslot.where(:start_time=>date.beginning_of_day..date.end_of_day) # i heart rails because of stuff like this
		
		render json: timeslots, :except=>global_fields_to_exclude

	end

	def create
		
		start_time_unix=params[:start_time].to_i # we should do some error checking here to be sure they send in expected formats
		duration=params[:duration]

		start_timestamp=Time.at(start_time_unix).to_datetime		# convert start time in Unix timestamp to a regular timestamp for storage in database, may want to do this at the model level if its the default behavior

		timeslot=Timeslot.create(:start_time=>start_timestamp,:duration=>duration) 

		render json: timeslot, :except=>global_fields_to_exclude

	end

end
