class MessagesController < ApplicationController
	def create
		@conversation = Conversation.includes(:recipient).find(params[:conversation_id])
		@message = Message.new(
			body: message_params[:body],
			conversation: @conversation,
			user: current_user
			)
		@message.save
	end

	private

	def message_params
		params.require(:message).permit(:body)
	end
end
