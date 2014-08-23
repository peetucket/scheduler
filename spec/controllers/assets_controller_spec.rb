require "rails_helper"

RSpec.describe Api::AssetsController do

 it "should create a new boat" do

  	expect(Asset.count).to eq (0) #no assets in database yet

  	name='Amazon Express' # values to test
  	capacity=8

  	post :create, :capacity=>capacity, :name=>name # post to the API

  	# check response
	expect(response).to be_success            
    json = JSON.parse(response.body)
    expect(json["id"].class).to eq(Fixnum)
    expect(json["capacity"]).to eq(capacity)
    expect(json["name"]).to eq(name)

    # check database
  	expect(Asset.count).to eq (1)
    a=Asset.last
    expect(a.name).to eq(name)
    expect(a.capacity).to eq(capacity)

 end

end
