class Post < ApplicationRecord
  mount_uploader :post_image, PostImageUploader
  belongs_to :user
end
