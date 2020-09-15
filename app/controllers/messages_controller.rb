class MessagesController < ApplicationController

	before_action :set_conversation
	before_action :check_conversation_member

	def create
		@message = Message.new(
			body: message_params[:body],
			conversation: @conversation,
			user: current_user
			)
		@message.save
		head :ok
	end

	private

	def set_conversation
		@conversation = Conversation.includes(:recipient).find(params[:conversation_id])
	end

	def check_conversation_member
		redirect_to root_path unless current_user == @conversation.sender || @current_user == @conversation.recipient
	end

	def message_params
		params.require(:message).permit(:body)
	end
end
