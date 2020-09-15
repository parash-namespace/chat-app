class ConversationsController < ApplicationController

	before_action :set_conversation, only: :show
	before_action :check_conversation_member, only: :show

	def create
		conversation = Conversation.get(current_user.id, params[:user_id])
		redirect_to conversation_path(conversation)
	end

	def show
		@users = User.where.not(id: current_user.id)
		@conversations = current_user.conversations.includes(:sender, :recipient)
		@messages = @conversation.messages
		mark_as_read
	end


	private
	def set_conversation
		@conversation = Conversation.find(params[:id])
	end

	def check_conversation_member
		redirect_to root_path unless current_user == @conversation.sender || current_user == @conversation.recipient
	end

	def mark_as_read
		unless current_user == @conversation.messages.last&.user
			@conversation.messages.update_all(read_at: Time.zone.now)
		end
	end

end