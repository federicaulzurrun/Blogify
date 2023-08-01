require 'rails_helper'

RSpec.describe 'Post Index', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user1) do
    User.create(name: 'Federica Ulzurrun', photo: 'https://unsplash.com/es/fotos/fIq0tET6llw', posts_counter: 10)
  end

  it "Displays the user's profile picture" do
    visit users_path(user_id: user1.id)
    expect(page).to have_css("img[src='#{user1.photo}']")
  end

  it 'Show users name' do
    visit users_path(user_id: user1.id)
    expect(page).to have_content(user1.name)
  end

  it 'Render the number of post of a given user' do
    visit users_path(user_id: user1.id)
    expect(page).to have_content(user1.posts_counter)
  end

  let!(:post) do
    Post.create(title: 'My First Post on Blogify', text: 'My First Post on Blogify testing', author: user1,
                comments_counter: 0, likes_counter: 0)
  end

  it 'Show the post title' do
    visit user_posts_path(user_id: user1.id)
    expect(page).to have_content(post.title)
  end

  it 'Show the post content' do
    visit user_posts_path(user_id: user1.id)
    expect(page).to have_content(post.text)
  end

  let!(:comment) do
    Comment.create(text: 'Test comment', author: user1, post: post)
  end

  it 'renders the comment of the post' do
    visit user_posts_path(user_id: user1.id)
    expect(page).to have_content(comment.text)
  end

  it 'Displays the number of likes' do
    visit user_posts_path(user_id: user1.id)
    expect(page).to have_content(post.likes_counter)
  end

  it 'Displays the number of comments' do
    visit user_posts_path(user_id: user1.id)
    expect(page).to have_content(post.comments_counter)
  end

  it 'When a user clicks on a post, they are directed to the individual posts/show page' do
    visit user_posts_path(user_id: user1.id)
    click_link post.title
    expect(page).to have_current_path(user_post_path(user_id: user1.id, id: post.id))
  end
end
