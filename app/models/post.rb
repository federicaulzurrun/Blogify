class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :update_posts_counter
  after_create :initialize_comments_counter
  before_validation :set_default_counters

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  def initialize_comments_counter
    update(comments_counter: 0, likes_counter: 0)
  end

  def set_default_counters
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end
end
