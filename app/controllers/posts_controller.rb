class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :destroy]
  def index
    @posts = Post.order("id DESC").all    #新帖子放前面，倒序
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save

    redirect_to posts_path
  end

  def destroy
    @post = current_user.posts.find(params[:id])   #只能删除自己的帖子
    @post.destroy
  end

  protected

  def post_params
    params.require(:post).permit(:content)
  end

end
