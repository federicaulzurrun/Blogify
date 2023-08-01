require 'rails_helper'

RSpec.describe '/users', type: :request do
  let(:user1) do
    User.create(
      name: 'Federica Ulzurrun',
      photo: 'https://unsplash.com/es/fotos/fIq0tET6llw',
      bio: 'Student - Developer',
      posts_counter: 0
    )
  end

  let(:user2) do
    User.create(
      name: 'Nshanji Hilary Ndzi',
      photo: 'https://unsplash.com/es/fotos/obyYZVKwCNI',
      bio: 'Developer',
      posts_counter: 0
    )
  end

  before do
    user1
    user2
  end

  describe 'GET/index' do
    it 'Displays all Blogify Users' do
      get '/'
      expect(response).to render_template 'users/index'
      expect(response.body).to include('Federica Ulzurrun')
      expect(response.body).to include('Nshanji Hilary Ndzi')
    end

    describe 'GET/show' do
      it 'Displays details for a given user' do
        get "/users/#{user1.id}"
        expect(response).to render_template 'users/show'
        expect(response.body).to include('Federica Ulzurrun')
        expect(response.body).to include('Student - Developer')
      end
    end
  end
end
