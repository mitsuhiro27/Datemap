class Post < ApplicationRecord
  mount_uploader :post_image, PostImageUploader
  belongs_to :user
  has_many :favorites, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
