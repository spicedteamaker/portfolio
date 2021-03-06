class PostsController < ApplicationController
  include ApplicationHelper

  before_action :check_privilege, only: [:new, :create, :edit, :update, :destroy]

  def index
    @pinnedPosts = Post.where(pinned: true).order(:created_at).reverse_order
    @posts = Post.order(:created_at).reverse_order.paginate(page: params[:page], per_page: 5)
    @tags = getTags(Post.all).sort

    unless params[:filtertag].nil?
      @filterOn = true
      filteredIDs = getFilteredPostIDs(params[:filtertag].to_s, Post.all)
      @posts = @posts.where(id: filteredIDs)
      @posts.order(:created_at).reverse_order.paginate(page: params[:page], per_page: 5)
    end

    respond_to do |format|
      format.html
      format.js
    end
    puts "*"*50
    puts filteredIDs
    puts "*"*50
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

  def getTags(posts)
    tags = []
    posts.each do |p|
      unless p.tags.nil?
        p.tags.each do |t|
          unless tags.include? t
            tags << t
          end
        end
      end
    end
    puts "*" * 30
    tags.each do |t|
      puts t
    end
    puts "*" * 30
    tags
  end

  def getFilteredPostIDs(tag, posts)
    filteredArray = []
    posts.each do |p|
      unless p.tags.nil?
        if p.tags.include? tag
          filteredArray << p
        end
      end
    end
    ids = []
    filteredArray.each do |f|
      ids << f.id
    end
    ids
  end

  def post_params
    params.require(:post).permit(:title, :body, :pinned, :main_picture)
  end
end
