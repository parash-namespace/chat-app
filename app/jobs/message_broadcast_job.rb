class MessageBroadcastJob < ApplicationJob
	queue_as :default

	def perform(message)
		sender = message.user
		recipient = message.conversation.opposed_user(sender)
		
		broadcast_message(sender, message)
		broadcast_message(recipient, message)
	end

	private

	def broadcast_message(user, message)
		ActionCable.server.broadcast(
			"conversations-#{user.id}",
			message: render_message(user, message),
			conversations_content: render_conversations(user),
			message_id: message.id,
			conversation_id: message.conversation.id
			)
	end

	def render_message(user, message)
		ApplicationController.render(
			partial: 'messages/message',
			locals: { message: message, user: user }
			)
	end

	def render_conversations(user)
		ApplicationController.render(
			partial: 'conversations/conversations',
			locals: { conversations: user.conversations, user: user }
			)
	end

end
