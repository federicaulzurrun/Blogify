require 'rails_helper'

RSpec.describe 'User Show', type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) do
    User.create(
      name: 'Federica Ulzurrun',
      photo: 'https://unsplash.com/es/fotos/fIq0tET6llw',
      bio: 'Student - Developer',
      posts_counter: 0
    )
  end

  let!(:post1) do
    Post.create(
      title: 'My First Post on Blogify',
      text: 'My First Post on Blogify testing',
      author: user,
      comments_counter: 2,
      likes_counter: 5
    )
  end

  let!(:post2) do
    Post.create(
      title: 'Second Post on Blogify',
      text: 'Second Post on Blogify testing',
      author: user,
      comments_counter: 3,
      likes_counter: 8
    )
  end

  it 'displays the user details' do
    visit user_path(user)

    expect(page).to have_css("img[src='https://unsplash.com/es/fotos/fIq0tET6llw']")
    expect(page).to have_content(user.name)
    expect(page).to have_content("Number of posts: #{user.posts_counter}")
    expect(page).to have_content(user.bio)
  end

  it 'displays the posts details' do
    visit user_path(user)

    expect(page).to have_content(post1.title)
    expect(page).to have_content(post1.text)
    expect(page).to have_content("Comments: #{post1.comments_counter} | Likes: #{post1.likes_counter}")

    expect(page).to have_content(post2.title)
    expect(page).to have_content(post2.text)
    expect(page).to have_content("Comments: #{post2.comments_counter} | Likes: #{post2.likes_counter}")
  end

  it 'redirects to create new post page when clicking on "Create a New Post" button' do
    visit user_path(user)

    click_link 'Create a New Post'
    expect(page).to have_current_path(new_user_post_path(user))
  end

  it 'redirects to individual post show page when clicking on a post' do
    visit user_path(user)

    click_link post1.title
    expect(page).to have_current_path(user_post_path(user, post1))

    visit user_path(user)

    click_link post2.title
    expect(page).to have_current_path(user_post_path(user, post2))
  end

  it 'redirects to all posts page when clicking on "See all posts" button' do
    visit user_path(user)

    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(user))
  end
end
