class CommentsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  load_and_authorize_resource

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(current_user, @post), notice: 'Comment was successfully created.'
    else
      render 'posts/show'
    end
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @post.decrement!(:comments_counter)
    @comment.destroy!
    redirect_to user_post_path(id: @post.id), notice: 'Comment deleted'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
