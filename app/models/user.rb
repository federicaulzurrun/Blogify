class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }

  after_create :update_user_posts_counter

  def update_user_posts_counter
    update(posts_counter: posts.count)
  end

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def last_posts
    posts.order(created_at: :desc).limit(5)
  end

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= 'user'
  end
end
