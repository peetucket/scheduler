require "rails_helper"

RSpec.describe Api::TimeslotsController do

	it "should create a new timeslot" do
	
		expect(Timeslot.count).to eq (0)

		start_time=1406052000 # values to test
		duration='120'
		start_timestamp=Time.at(start_time).to_datetime

	  	post :create, :start_time=>start_time, :duration=>duration # post to the API

	  	# check response
		expect(response).to be_success            
	    json = JSON.parse(response.body)
	    expect(json["id"].class).to eq(Fixnum)
	    expect(json["duration"]).to eq(duration.to_i)
		expect(json["start_time"]).to eq(start_time)
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

end