class Api::BookingsController < ApplicationController

	def create
		
		timeslot_id=params[:timeslot_id]
		size=params[:size]

		booking=Booking.create(:timeslot_id=>timeslot_id,:tickets=>size)

		puts booking.errors.inspect

		render json: booking, :except=>global_fields_to_exclude

	end

end
