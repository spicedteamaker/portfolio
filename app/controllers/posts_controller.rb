class PostsController < ApplicationController
  include ApplicationHelper

  before_action :check_privilege, only: [:new, :create, :edit, :update, :destroy]

  def index
    @pinnedPosts = Post.where(pinned: true).order(:created_at).reverse_order
    @posts = Post.order(:created_at).reverse_order.paginate(page: params[:page], per_page: 5)
    @lastPageNum = Post.page(1).total_pages
    @test = "Hello, World!"

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.tags = makeTags(params.fetch(:post, {}).permit(:tags)["tags"].to_s)
    if @post.valid?
      @post.save
      redirect_to post_path(@post)
    elsif !@post.valid?
      render new_post_path
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tags = tagify(@post.tags)
  end

  def update
    @post = Post.find(params[:id])
    @post.tags = makeTags(params.fetch(:post, {}).permit(:tags)["tags"].to_s)
    if params[:main_picture] != nil
      @post.main_picture.attach params[:main_picture]
    end
    @post.update(post_params)
    if @post.valid?
      @post.save
      redirect_to post_path(@post)
    elsif !@post.valid?
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

  private

  def tagify(tagArray)
    # converts to string with hashtags
    if tagArray.nil?
      return []
    end
    tagString = tagArray * "#"
    firstHash = "#"
    unless tagString.empty?
      return firstHash + tagString
    end
    tagString
  end

  def makeTags(tagString)
    a = tagString.split("#")
    # we drop the first element, because splitting it adds an empty char at [0]
    a.drop(1)
  end

  def post_params
    params.require(:post).permit(:title, :body, :pinned, :main_picture)
  end
end
