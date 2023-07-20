class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  after_create :update_posts_counter

  def update_posts_counter
    update(comments_counter: comments.count)
  end

  def update_comments_counter
    update(comments_counter: comments.count)
  end

  def update_likes_count
    update(likes_counter: likes.count)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
