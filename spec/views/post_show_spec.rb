require 'rails_helper'

RSpec.describe 'Post Show', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user1) do
    User.create(name: 'Federica Ulzurrun', photo: 'https://unsplash.com/es/fotos/fIq0tET6llw', posts_counter: 10)
  end

  let!(:post) do
    Post.create(title: 'My First Post on Blogify', text: 'My First Post on Blogify testing', author: user1,
                comments_counter: 0, likes_counter: 0)
  end

  let!(:comment) do
    Comment.create(text: 'Test comment Blogify', author: user1, post: post)
  end

  it 'Show the post title' do
    visit user_posts_path(user_id: user1.id, id: post.id)
    expect(page).to have_content(post.title)
  end

  it 'Show the post author' do
    visit user_posts_path(user_id: user1.id, id: post.id)
    expect(page).to have_content(user1.name)
  end

  it 'Displays the comments counter of the post' do
    visit user_posts_path(user_id: user1.id, id: post.id)
    expect(page).to have_content(post.comments_counter)
  end

  it 'Displays the number of likes of the post' do
    visit user_posts_path(user_id: user1.id, id: post.id)
    expect(page).to have_content(post.likes_counter)
  end

  it 'shows posts text' do
    visit user_posts_path(user_id: user1.id, id: post.id)
    expect(page).to have_content(post.text)
  end

  it 'shows the username' do
    visit user_posts_path(user_id: user1.id, id: post.id)
    expect(page).to have_content(comment.author.name)
  end

  it 'renders the comments' do
    visit user_posts_path(user_id: user1.id, id: post.id)
    expect(page).to have_content(comment.text)
  end
end
