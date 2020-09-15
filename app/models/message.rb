class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation, touch: true

  validates :body, presence: true

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  scope :unread, -> { where read_at: nil }

end
