class Api::AssignmentsController < ApplicationController

	def create
		
		timeslot_id=params[:timeslot_id]
		asset_id=params[:boat_id]

		assignment=Assignment.create(:timeslot_id=>timeslot_id,:asset_id=>asset_id)

		render json: assignment, :except=>[:remaining]+global_fields_to_exclude

	end

end
