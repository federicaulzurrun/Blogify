require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John', posts_counter: 0) }
  let(:post) { Post.create(author: user, title: 'Hello', text: 'Test post', comments_counter: 0, likes_counter: 0) }

  subject { Like.create(author: user, post: post) }

  context 'associations' do
    it 'belongs to an author' do
      expect(subject.author).to eq(user)
    end

    it 'belongs to a post' do
      expect(subject.post).to eq(post)
    end
  end

  context 'after_create :update_likes_count' do
    it 'updates the likes_counter of the associated post after creating a like' do
      expect(post.likes_counter).to eq(0)

      # Create a new like
      subject

      # Expect the likes_counter of the post to be updated
      expect(post.reload.likes_counter).to eq(1)
    end
  end
end
