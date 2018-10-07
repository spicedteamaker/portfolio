class PostsController < ApplicationController
  include ApplicationHelper

  before_action :check_privilage, only: [:new, :create, :edit]

  def index
    @posts = Post.order(:created_at).reverse_order.page params[:page]
    @lastPageNum = Post.page(1).total_pages
  end

  def create
    @post = Post.create(post_params)
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
  end

  def show
    @post = Post.find(params[:id])
  end

  def catalog

  end

  def check_privilage
    if !current_user.nil?
      if !(current_user.operator? || current_user.admin?)
        flash[:error] = "You do not have permission to access that page."
        redirect_to root_path
      end
    else
      flash[:error] = "You must log in to access that page."
      redirect_to new_user_session_path
    end
  end

  def post_params
    params.require(:post).permit(:title, :body, :main_picture)
  end
end
