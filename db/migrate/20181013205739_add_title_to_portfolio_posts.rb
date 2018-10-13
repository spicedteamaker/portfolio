class AddTitleToPortfolioPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :portfolio_posts, :title, :string
  end
end
