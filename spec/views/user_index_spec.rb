require 'rails_helper'

RSpec.describe 'User Index', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:user1) do
    User.create(
      name: 'Federica Ulzurrun',
      photo: 'https://unsplash.com/es/fotos/fIq0tET6llw',
      bio: 'Student - Developer',
      posts_counter: 0
    )
  end

  let!(:user2) do
    User.create(
      name: 'Nshanji Hilary Ndzi',
      photo: 'https://unsplash.com/es/fotos/obyYZVKwCNI',
      bio: 'Developer',
      posts_counter: 0
    )
  end

  it 'displays the username of all other users' do
    visit users_path

    expect(page).to have_content('Federica Ulzurrun')
    expect(page).to have_content('Nshanji Hilary Ndzi')
  end

  it 'displays the profile picture for each user' do
    visit users_path

    expect(page).to have_css("img[src='https://unsplash.com/es/fotos/fIq0tET6llw']")
    expect(page).to have_css("img[src='https://unsplash.com/es/fotos/obyYZVKwCNI']")
  end

  it 'displays the profile picture for each user' do
    visit users_path

    expect(page).to have_css('img.user-photo', count: 2)
  end

  it 'redirects to the user show page when clicking on a user' do
    visit users_path

    click_link 'Federica Ulzurrun'
    expect(page).to have_current_path(user_path(user1))
    
    visit users_path

    click_link 'Nshanji Hilary Ndzi'
    expect(page).to have_current_path(user_path(user2))
  end
end

