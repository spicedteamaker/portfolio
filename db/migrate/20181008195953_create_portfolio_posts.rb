class CreatePortfolioPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolio_posts do |t|

      t.timestamps
    end
  end
end
