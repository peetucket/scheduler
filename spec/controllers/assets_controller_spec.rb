require "rails_helper"

RSpec.describe Api::AssetsController do

 it "should create a new boat" do

  	post :create, :capacity=>8, :name=>'Amazon Express'

	expect(response).to be_success            
    json = JSON.parse(response.body)
    expect(json["id"]).to eq(1) # we get the expected it back
    expect(json["capacity"]).to eq(8)
    expect(json["name"]).to eq('Amazon Express')

 end

end
