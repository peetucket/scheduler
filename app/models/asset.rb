class Asset < ActiveRecord::Base

	belongs_to :client
	has_many :timeslots, :through=> :assignments
	has_many :assignments
	
	KINDS=%w{boat kyak}  # could have a join table instead if these needed to be dynamic

	validates :availability, numericality: { only_integer: true, greater_than: 0 }
	validates :client_id, numericality: { only_integer: true }
  	validate :check_kinds

	before_validation :set_default_kind, :set_default_client

	def set_default_client
		self.client_id=Client.where(:name=>Scheduler::Application.config.default_client_name).limit(1).first if client_id.blank?
	end

	def set_default_kind
		self.kind=Scheduler::Application.config.default_kind if kind.blank?
	end

	def check_kinds
       errors.add(:kind, :not_valid) unless KINDS.include? kind.to_s
   	end

end
