class PostsController < ApplicationController
  include ApplicationHelper

  before_action :check_privilege, only: [:new, :create, :edit, :update, :destroy]

  def index
    @pinnedPosts = Post.where(pinned: true).order(:created_at).reverse_order
    @posts = Post.order(:created_at).reverse_order.page params[:page]
    @lastPageNum = Post.page(1).total_pages
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.valid?
      redirect_to post_path(@post)
    elsif !@post.valid?
      render new_post_path
    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    if @post.valid?
      @post.save
      redirect_to post_path(@post)
    elsif !post.valid?
      render edit_post_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
  end

  def catalog
    @posts = Post.order(:created_at).reverse_order
    @month = nil
    @year = nil
    @colNum = 0
    @colMax = @colNum + 4
  end

  def post_params
    params.require(:post).permit(:title, :body, :pinned, :main_picture)
  end
end
