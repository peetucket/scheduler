class Api::BookingsController < ApplicationController

	def create
		
		timeslot_id=params[:timeslot_id]
		tickets=params[:size]

		booking=Booking.create(:timeslot_id=>timeslot_id,:tickets=>tickets)

		render json: booking_output(booking)

	end

	private
	# since our output is not a straight model object, and has different method names, lets construct it (probably better if this method was in the model)
	def booking_output(booking)
	   {:id=>booking.id,:size=>booking.tickets,:timeslot_id=>booking.timeslot_id}
	end

end
