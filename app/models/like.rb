class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  after_create :update_likes_count

  validates :author_id, uniqueness: { scope: :post_id, message: 'You have already liked this post.' }

  def update_likes_count
    post.update(likes_counter: post.likes.count)
  end
end
