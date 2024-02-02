class Message < ApplicationRecord
  belongs_to :author, class_name: 'User'

  validates :author, :content, presence: true

  def edited?
    created_at != updated_at
  end

  private

  def channel
    'common'
  end
end
