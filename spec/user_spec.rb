require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'Jules', posts_counter: 0) }

  context 'validations' do
    it 'name should be presented' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'posts_counter should not be less than zero' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

    it 'posts_counter should be greater than or equal to zero' do
      subject.posts_counter = 0
      expect(subject).to be_valid

      subject.posts_counter = 1
      expect(subject).to be_valid
    end

    it 'posts_counter should be an integer' do
      subject.posts_counter = 1.5
      expect(subject).to_not be_valid
    end
  end

  context '#recent_posts' do
    it 'returns the three most recent posts' do
      third_post = Post.create(author: subject, title: 'Third', text: 'Third Post', comments_counter: 0,
                               likes_counter: 0, created_at: 3.days.ago)
      second_post = Post.create(author: subject, title: 'Second', text: 'Second Post', comments_counter: 0,
                                likes_counter: 0, created_at: 2.days.ago)
      first_post = Post.create(author: subject, title: 'First', text: 'First Post', comments_counter: 0,
                               likes_counter: 0, created_at: 1.day.ago)

      other_user = User.create(name: 'Other User', posts_counter: 0)
      Post.create(author: other_user, title: 'Other User Post', text: 'Other User Post', comments_counter: 0,
                  likes_counter: 0, created_at: 1.day.ago)

      recent_posts = subject.recent_posts
      expect(recent_posts.length).to eq(3)
      expect(recent_posts).to eq([first_post, second_post, third_post])
    end

    it 'returns empty array when user has no posts' do
      expect(subject.posts).to be_empty

      recent_posts = subject.recent_posts
      expect(recent_posts).to be_empty
    end

    it 'returns fewer than three posts when user has less than three posts' do
      second_post = Post.create(author: subject, title: 'Second', text: 'Second Post', comments_counter: 0,
                                likes_counter: 0, created_at: 2.days.ago)
      first_post = Post.create(author: subject, title: 'First', text: 'First Post', comments_counter: 0,
                               likes_counter: 0, created_at: 1.day.ago)

      recent_posts = subject.recent_posts
      expect(recent_posts.length).to eq(2)
      expect(recent_posts).to eq([first_post, second_post])
    end
  end
end
