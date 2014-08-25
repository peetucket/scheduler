require "rails_helper"

RSpec.describe Api::AssignmentsController do

	it "should create an assignement" do
	
	 	expect(Assignment.count).to eq (0) 
	
	 	timeslot=Timeslot.create(:start_time=>1406052000,:duration=>'120') # these should really be fixtures
	 	boat=Asset.create(:capacity=>'8',:name=>'Pete\'s Rockin Boat')
	 	
	  	post :create, :timeslot_id=>timeslot.id, :boat_id=>boat.id # post to the API

	  	# check response
		expect(response).to be_success            

	    # check database
	 	expect(Assignment.count).to eq (1) 
	    a=Assignment.last
	    expect(a.timeslot_id).to eq(timeslot.id)
	    expect(a.asset_id).to eq(boat.id)
	    expect(a.remaining).to eq(boat.capacity)

	end

end