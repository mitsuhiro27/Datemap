class ChangeDataPostImageToPosts < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :post_image, :string
  end
end
