class Client < ActiveRecord::Base

	has_many :assets
	
	validates :name, presence: true

	def self.default
  		@@default ||= Client.where(:name=>Scheduler::Application.config.default_client_name).limit(1).first
	end

end
