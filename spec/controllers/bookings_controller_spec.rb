require "rails_helper"

RSpec.describe Api::BookingsController do

	it "should create a booking" do

		expect(Booking.count).to eq (0) 

		num_tickets=6

	 	timeslot=Timeslot.create(:start_time=>1406052000,:duration=>'120') # these should really be fixtures
	 	boat=Asset.create(:capacity=>'8',:name=>'Pete\'s Rockin Boat')
	 	assignment=Assignment.create(:timeslot_id=>timeslot.id,:asset_id=>boat.id)

	 	post :create, :booking=>{:timeslot_id=>timeslot.id,:size=>num_tickets}

	  	# check response
		expect(response).to be_success            
		
		json = JSON.parse(response.body)
	    expect(json["id"].class).to eq(Fixnum)
	    expect(json["size"]).to eq(num_tickets)
	    expect(json["timeslot_id"]).to eq(timeslot.id)
	    
	    # check database
	 	expect(Booking.count).to eq (1) 
	    b=Booking.last
	    expect(b.timeslot_id).to eq(timeslot.id)
	    expect(b.tickets).to eq(num_tickets)

	end
	
end
