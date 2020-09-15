class ConversationChannel < ApplicationCable::Channel
	def subscribed
		stream_from "conversations-#{current_user.id}"
	end

	def unsubscribed
		stop_all_streams
	end

	def receive(data)
		message = Message.find(data['message_id'])
		message.update_column(:read_at, Time.zone.now) if current_user != message.user
	end
end