class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_one_attached :photo
  has_many :conversations

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  def conversations
  	Conversation.where(sender_id: id).or(Conversation.where(recipient_id: id))
  end
end
