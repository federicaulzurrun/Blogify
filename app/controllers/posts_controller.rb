class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  load_and_authorize_resource
  before_action :set_user, only: %i[new create]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    @comments = Comment.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = @user.posts.new
  end

  def create
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    author = @post.author
    author.decrement!(:posts_counter)
    @post.destroy!
    redirect_to user_posts_path(id: author.id), notice: 'Post deleted!'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
