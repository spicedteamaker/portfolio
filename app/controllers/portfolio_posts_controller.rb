class PortfolioPostsController < ApplicationController
  before_action :check_privilege, only: [:new, :create, :edit, :update, :destroy]

  def index
    @editMode = false
    @portfolioPosts = PortfolioPost.all
    if params[:edit] == "true"
      @editMode = true
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
    redirect_to new_portfolio_post_path
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
    picture = ActiveStorage::Attachment.find(params[:id])
    picture.purge_later
    page = params[:page].to_i
    pageTotal = params[:pageTotal].to_i
    # if the only picture on a page is deleted, return the previous page
    if pageTotal == 0
      redirect_to portfolio_posts_path(edit: true, page: page - 1)
    else
      redirect_to portfolio_posts_path(edit: true, page: page)
    end
  end

  def show
  end

  def portfolio_post_params
    params.require(:portfolio_post).permit(:title, pictures: [])
  end

  def paginate(pictures, page)
    onLastPage = false
    onFirstPage = false
    if page == 1 || page < 1
      onFirstPage = true
      if pictures[8].nil?
        onLastPage = true
      end
      return {pictures: (pictures[0..7]), onFirstPage: onFirstPage, onLastPage: onLastPage}
    end

    amountToRender = 8
    last = page * amountToRender - 1
    first = (page * amountToRender) - amountToRender
    if pictures[last+1].nil?
      onLastPage = true
      return {pictures: (pictures[first..last]), onFirstPage: onFirstPage, onLastPage: onLastPage}
    end
    return {pictures: (pictures[first..last]), onFirstPage: onFirstPage, onLastPage: onLastPage}
  end

  def pagination_range(page, total)
    # the range of pages we want showing in the nav
    range = 5
    # leftmost page, but we increment
    x = -2
    list = []
    range.times do
      if page + x > 0 && page+x < total+1
        list.push(page + x)
      end
      x+=1
    end
    return list
  end

  def get_total_pages(pictures)
    # does not include 0
    perPage = 8
    total = pictures.count
    quotient = total / 8
    remainder = total % 8

    # There's a page after the quotient
    if remainder > 0 && total > 8
      return quotient + 1
    end
    # no remainder
    return quotient
  end
end
