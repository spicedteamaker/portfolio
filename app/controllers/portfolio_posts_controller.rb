class PortfolioPostsController < ApplicationController
  before_action :check_privilage, only: [:new, :create, :edit, :update, :destroy]
  def index
    @editMode = false
    @portfolioPosts = PortfolioPost.all
    if params[:edit] == "true"
      @editMode = true
    end
  end

  def create
    portfolioPost = PortfolioPost.create(portfolio_post_params)
    redirect_to portfolio_posts_path
  end

  def new
    @portfolioPost = PortfolioPost.new
  end

  def edit
  end

  def update
  end

  def destroy
    picture = ActiveStorage::Attachment.find(params[:id])
    picture.purge_later
    redirect_to portfolio_posts_path(edit: true)
  end

  def show
  end

  def portfolio_post_params
    params.require(:portfolio_post).permit(pictures: [])
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
end
