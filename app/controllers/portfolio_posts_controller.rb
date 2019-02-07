class PortfolioPostsController < ApplicationController
  before_action :check_privilege, only: [:new, :create, :edit, :update, :destroy]

  def index
    @editMode = false
    @portfolioPosts = PortfolioPost.order(:created_at).reverse_order.paginate(page: params[:page], per_page: 20)
    if params[:edit] == "true"
      @editMode = true
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    # we allow for multiple image uploads, and create an individual
    # portfolio post with each file uploaded
    puts "*" * 30
    params[:pictures].each do |picture|
      p = PortfolioPost.new(title: params[:title])
      p.picture.attach(picture)
      p.save
    end
    puts "*" * 30
    redirect_to portfolio_posts_path
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
    picture = PortfolioPost.find params[:id]
    picture.delete
    redirect_to portfolio_posts_path(edit: true)
  end

  def show
    @picture = PortfolioPost.find(params[:id]).picture
  end

  def portfolio_post_params
    params.require(:portfolio_post).permit(:title, pictures: [])
  end

end
