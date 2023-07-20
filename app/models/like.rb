class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_likes_count

  def update_likes_count
    post.update(likes_counter: post.likes.count)
  end
end
