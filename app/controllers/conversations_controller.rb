class ConversationsController < ApplicationController

	def create
		conversation = Conversation.get(current_user.id, params[:user_id])
		redirect_to conversation_path(conversation)
	end

	def show
		@users = User.where.not(id: current_user.id)
		@conversation = Conversation.find(params[:id])
		@messages = @conversation.messages
	end

end