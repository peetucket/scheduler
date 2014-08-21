class Asset < ActiveRecord::Base

	belongs_to :client

	KINDS=%w{boat kyak}

	validates :availability, numericality: { only_integer: true, greater_than: 0 }

	before_validation :set_default_kind

	def set_default_kind
		self.kind='boat' if kind.blank?
	end

	def check_kinds
       errors.add(:kind, :not_valid) unless KINDS.include? kind.to_s
   	end

end
