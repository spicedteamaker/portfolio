class CreateHeaderImages < ActiveRecord::Migration[5.2]
  def change
    create_table :header_images do |t|

      t.timestamps
    end
  end
end
