class AddTitleToHeaderImage < ActiveRecord::Migration[5.2]
  def change
    add_column :header_images, :title, :string
  end
end
