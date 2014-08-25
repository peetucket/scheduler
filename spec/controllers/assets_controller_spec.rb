require "rails_helper"

RSpec.describe Api::AssetsController do

 it "should create a new boat" do

  	expect(Asset.count).to eq (0) #no assets in database yet

  	name='Amazon Express' # values to test
  	capacity=8

  	post :create, :boat=>{:capacity=>capacity, :name=>name} # post to the API

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

 it "should list boats" do

  	name_1='Amazon Express' # values to test
  	capacity_1=8
  	name_2='Amazon Mini' 
  	capacity_2=4

  	post :create, :boat=>{:capacity=>capacity_1, :name=>name_1} # create some boats
  	post :create, :boat=>{:capacity=>capacity_2, :name=>name_2} 

  	get :index

  	# check response
	expect(response).to be_success            
    json = JSON.parse(response.body)
	expect(json.class).to eq(Array) # could refactor this to be less verbose
	expect(json.size).to eq(2) 
	expect(json[0]['name']).to eq(name_1)
	expect(json[0]['capacity']).to eq(capacity_1)
	expect(json[1]['name']).to eq(name_2)
	expect(json[1]['capacity']).to eq(capacity_2)

 end


end
