require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:author) { User.create(name: 'Jules', posts_counter: 0) }

  subject do
    Post.create(
      author: author,
      title: 'Hello',
      text: 'Working with Rspec.',
      comments_counter: 0,
      likes_counter: 0
    )
  end

  let(:first_comment) { Comment.create(post: subject, author: author, text: 'Hi Jules!') }
  let(:second_comment) { Comment.create(post: subject, author: author, text: 'Nice') }
  let(:third_comment) { Comment.create(post: subject, author: author, text: 'Congratulations') }
  let(:fourth_comment) { Comment.create(post: subject, author: author, text: 'Excellent') }
  let(:fifth_comment) { Comment.create(post: subject, author: author, text: 'Good Job') }
  let(:sixth_comment) { Comment.create(post: subject, author: author, text: 'Like it') }

  let(:first_like) { Like.create(post: subject, author: author) }
  let(:second_like) { Like.create(post: subject, author: author) }

  context 'validations' do
    it 'title should be presented' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'title should be no longer than 250 characters' do
      subject.title = 'a' * 250
      expect(subject).to be_valid

      subject.title = 'a' * 251
      expect(subject).to_not be_valid
    end

    it 'comments_counter should not be less than zero' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be greater than or equal to zero' do
      subject.comments_counter = 0
      expect(subject).to be_valid

      subject.comments_counter = 1
      expect(subject).to be_valid
    end

    it 'comments_counter should be an integer' do
      subject.comments_counter = 1.5
      expect(subject).to_not be_valid
    end

    it 'likes_counter should not be less than zero' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'likes_counter should be greater than or equal to zero' do
      subject.likes_counter = 0
      expect(subject).to be_valid

      subject.likes_counter = 1
      expect(subject).to be_valid
    end

    it 'likes_counter should be an integer number' do
      subject.likes_counter = 1.5
      expect(subject).to_not be_valid
    end
  end

  context 'after_create callback' do
    it 'should update author posts_counter after creating a new post' do
      expect { subject.save }.to change { author.reload.posts_counter }.by(1)
    end
  end

  context '#recent_comments' do
    it 'returns the five most recent comments' do
      first_comment
      second_comment
      third_comment
      fourth_comment
      fifth_comment
      sixth_comment
      recent_comments_array = [sixth_comment, fifth_comment, fourth_comment, third_comment, second_comment]
      expect(subject.recent_comments).to eq(recent_comments_array)
    end
  end
end
