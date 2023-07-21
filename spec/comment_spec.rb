require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John', posts_counter: 0) }
  let(:post) { Post.create(author: user, title: 'Hello', text: 'Test post', comments_counter: 0, likes_counter: 0) }

  subject { Comment.create(author: user, post: post, text: 'Test comment') }

  context 'associations' do
    it 'belongs to an author' do
      expect(subject.author).to eq(user)
    end

    it 'belongs to a post' do
      expect(subject.post).to eq(post)
    end
  end

  context 'after_create :update_comments_counter' do
    it 'updates the comments_counter of the associated post after creating a comment' do
      expect(post.comments_counter).to eq(0)

      subject

      expect(post.reload.comments_counter).to eq(1)
    end
  end
end
