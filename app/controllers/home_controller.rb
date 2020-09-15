class HomeController < ApplicationController
  def index
  	@users = User.where.not(id: current_user.id)

  	@conversations = current_user.conversations.includes(:sender, :recipient)
  end
end
