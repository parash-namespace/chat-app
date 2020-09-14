class Conversation < ApplicationRecord

	belongs_to :sender, class_name: "User"
	belongs_to :recipient, class_name: "User"

	has_many :messages, dependent: :destroy

	validates :sender_id, uniqueness: { scope: :recipient_id }


	# gets user ids and returns data, used in self.get
	scope :between, lambda { |sender_id, recipient_id| 
		where(sender_id: sender_id, recipient_id: recipient_id).or(
			where(sender_id: recipient_id, recipient_id: sender_id)
			)
	}


	def self.get(sender_id, recipient_id)
		conversation = between(sender_id, recipient_id).first
		return conversation if conversation.present?

		create(sender_id: sender_id, recipient_id: recipient_id)
	end

	def opposed_user(user)
		user == recipient ? sender : recipient
	end

end
