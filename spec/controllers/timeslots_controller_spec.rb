require "rails_helper"

RSpec.describe Api::TimeslotsController do

	it "should create a new timeslot" do
	
		expect(Timeslot.count).to eq (0)

		start_time="1406052000" # values to test
		duration='120'
		start_timestamp=Time.at(start_time.to_i).to_datetime

	  	post :create, :timeslot=>{:start_time=>start_time, :duration=>duration} # post to the API

	  	# check response
		expect(response).to be_success            
	    json = JSON.parse(response.body)
	    expect(json["id"].class).to eq(Fixnum)
	    expect(json["duration"]).to eq(duration.to_i)
		expect(json["start_time"]).to eq(start_time.to_i)
	    expect(json["availability"]).to eq(0)
	    expect(json["customer_count"]).to eq(0)
	    expect(json["boats"]).to eq([])

	    # check database
	  	expect(Timeslot.count).to eq (1)
	    t=Timeslot.last
	    expect(t.duration).to eq(duration.to_i)
	    expect(t.start_time).to eq(start_time.to_s)
	    expect(t.start_timestamp).to eq(start_timestamp)

	end

	it "should get timeslots" do
	
		start_time_1="1406052000" # values to test
		duration_1='120'
		start_time_2="1406072000"
		duration_2='60'

	  	post :create, :timeslot=>{:start_time=>start_time_1, :duration=>duration_1} # create two timeslots
	  	post :create, :timeslot=>{:start_time=>start_time_2, :duration=>duration_2} # create two timeslots

	  	get :index, :date=>'2014-07-22'

        expect(response).to be_success            
	    json = JSON.parse(response.body)
		expect(json.class).to eq(Array) # could refactor this to be less verbose
		expect(json.size).to eq(2) 
		expect(json[0]['start_time']).to eq(start_time_1)
		expect(json[0]['duration']).to eq(duration_1.to_i)
		expect(json[0]['availability']).to eq(0)
		expect(json[0]['customer_count']).to eq(0)
		expect(json[0]['boats']).to eq([])
		expect(json[1]['start_time']).to eq(start_time_2)
 		expect(json[1]['duration']).to eq(duration_2.to_i)
		expect(json[1]['availability']).to eq(0)
		expect(json[1]['customer_count']).to eq(0)
		expect(json[1]['boats']).to eq([])

	end

	it "should show correct number availabilty for two boats at the same timeslot after a booking (CASE1)" do

		num_tickets=6
		start_time_1="1406052000" # values to test
		duration_1='120'

	 	timeslot=Timeslot.create(:start_time=>start_time_1,:duration=>duration_1) # these should really be fixtures
	 	boat1=Asset.create(:capacity=>'8',:name=>'Amazon Express')
	 	boat2=Asset.create(:capacity=>'4',:name=>'Amazon Express Mini')
	 	assignment1=Assignment.create(:timeslot_id=>timeslot.id,:asset_id=>boat1.id)
	 	assignment2=Assignment.create(:timeslot_id=>timeslot.id,:asset_id=>boat2.id)

	  	get :index, :date=>'2014-07-22'

	    json = JSON.parse(response.body) #refactor me
		expect(json.class).to eq(Array) 
		expect(json.size).to eq(1) 
		expect(json[0]['start_time']).to eq(start_time_1)
		expect(json[0]['duration']).to eq(duration_1.to_i)
		expect(json[0]['availability']).to eq(8)
		expect(json[0]['customer_count']).to eq(0)
		expect(json[0]['boats']).to eq([boat1.id,boat2.id])

	 	booking=Booking.create(:timeslot_id=>timeslot.id,:tickets=>num_tickets) # now make a booking

	  	get :index, :date=>'2014-07-22'

	    json = JSON.parse(response.body)
		expect(json.class).to eq(Array) 
		expect(json.size).to eq(1) 
		expect(json[0]['start_time']).to eq(start_time_1)
		expect(json[0]['duration']).to eq(duration_1.to_i)
		expect(json[0]['availability']).to eq(4)
		expect(json[0]['customer_count']).to eq(num_tickets)
		expect(json[0]['boats']).to eq([boat1.id,boat2.id])

	end

	it "should show correct number availabilty for one boat with overlapping timeslots after a booking (CASE2)" do

		num_tickets=2
		start_time_1="1406052000" # values to test
		duration_1='120'
		start_time_2="1406055600"
		duration_2='120'

	 	timeslot1=Timeslot.create(:start_time=>start_time_1,:duration=>duration_1) # these should really be fixtures
	 	timeslot2=Timeslot.create(:start_time=>start_time_2,:duration=>duration_2) # these should really be fixtures
	 	boat1=Asset.create(:capacity=>'8',:name=>'Amazon Express')
	 	assignment1=Assignment.create(:timeslot_id=>timeslot1.id,:asset_id=>boat1.id)
	 	assignment2=Assignment.create(:timeslot_id=>timeslot2.id,:asset_id=>boat1.id)

	  	get :index, :date=>'2014-07-22'

	    json = JSON.parse(response.body) #refactor me
		expect(json.class).to eq(Array) 
		expect(json.size).to eq(2) 
		expect(json[0]['start_time']).to eq(start_time_1)
		expect(json[0]['duration']).to eq(duration_1.to_i)
		expect(json[0]['availability']).to eq(8)
		expect(json[0]['customer_count']).to eq(0)
		expect(json[0]['boats']).to eq([boat1.id])
		expect(json[1]['start_time']).to eq(start_time_2)
 		expect(json[1]['duration']).to eq(duration_2.to_i)
		expect(json[1]['availability']).to eq(8)
		expect(json[1]['customer_count']).to eq(0)
		expect(json[1]['boats']).to eq([boat1.id])

	 	booking=Booking.create(:timeslot_id=>timeslot2.id,:tickets=>num_tickets) # now make a booking

	  	get :index, :date=>'2014-07-22'

	    json = JSON.parse(response.body)
		expect(json.class).to eq(Array) 
		expect(json.size).to eq(2) 
		expect(json[0]['start_time']).to eq(start_time_1)
		expect(json[0]['duration']).to eq(duration_1.to_i)
		expect(json[0]['availability']).to eq(0)
		expect(json[0]['customer_count']).to eq(0)
		expect(json[0]['boats']).to eq([boat1.id])
		expect(json[1]['start_time']).to eq(start_time_2)
 		expect(json[1]['duration']).to eq(duration_2.to_i)
		expect(json[1]['availability']).to eq(6)
		expect(json[1]['customer_count']).to eq(2)
		expect(json[1]['boats']).to eq([boat1.id])

	end

end