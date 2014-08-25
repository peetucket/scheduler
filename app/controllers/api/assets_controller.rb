class Api::AssetsController < ApplicationController

	before_filter :set_default_client

	def index

		kind=params[:kind] || Scheduler::Application.config.default_asset

		assets=Asset.where(:kind=>kind,:client_id=>@client_id)

		render json: assets, :except=>fields_to_exclude

	end

	def create

		name=params[:boat][:name]
		capacity=params[:boat][:capacity]

		asset=Asset.create(:name=>name,:capacity=>capacity,:client_id=>@client_id)

		render json: asset, :except=>fields_to_exclude

	end

	private
	def set_default_client
		@client_id=params[:client_id] || Client.default.id
	end

	def fields_to_exclude
		global_fields_to_exclude + [:kind,:client_id]
	end

end
