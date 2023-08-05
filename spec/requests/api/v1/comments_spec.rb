require 'swagger_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    parameter name: 'user_id', in: :path, type: :string, description: 'ID of a user'
    parameter name: 'post_id', in: :path, type: :string, description: 'ID of a post'

    get 'List all comments on a user\'s post' do
      tags 'Comments'
      produces 'application/json'
      response 200, 'Successful' do
        schema type: :array,
               items: {
                 properties: {
                   id: { type: :integer },
                   text: { type: :string }
                 },
                 required: [:id, :text]
               }

        run_test! do
          # Your test logic goes here
          # For example:
          user = create(:user)
          post = create(:post, user: user)
          create_list(:comment, 3, post: post)

          get "/api/v1/users/#{user.id}/posts/#{post.id}/comments"
          expect(response).to have_http_status(:success)
        end
      end
    end

    post 'Create a comment on a user\'s post' do
      tags 'Comments'
      consumes 'application/json'

      parameter name: 'X-Token', in: :header, type: :string, description: 'API token', required: true
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: [:text]
      }
      description 'Your API token is generated on sign up. It is located on your user profile page.'

      response 201, 'Comment created' do
        schema type: :object,
               properties: {
                 success: { type: :string }
               },
               required: [:success]

        run_test! do
          # Your test logic goes here
          # For example:
          user = create(:user)
          post = create(:post, user: user)

          post "/api/v1/users/#{user.id}/posts/#{post.id}/comments", params: { comment: { text: 'Great post!' } }.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
          expect(response).to have_http_status(:created)
        end
      end

      response 400, 'Comment not created' do
        schema type: :object,
               properties: {
                 error: { type: :string }
               },
               required: [:error]

        run_test! do
          # Your test logic goes here
          # For example:
          user = create(:user)
          post = create(:post, user: user)

          post "/api/v1/users/#{user.id}/posts/#{post.id}/comments", params: { comment: { text: '' } }.to_json, headers: { 'CONTENT_TYPE' => 'application/json' }
          expect(response).to have_http_status(:bad_request)
        end
      end
    end
  end
end

