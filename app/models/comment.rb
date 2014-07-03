class Comment < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates_presence_of :user_id, :content
  validates :content, length: { maximum: 140 }
end
