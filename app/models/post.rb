class Post < ApplicationRecord
  mount_uploader :post_image, PostImageUploader
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  validates :title, :content, :address, presence: true
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :most_favorited, -> {includes(:favorited_users).sort {|a,b| b.favorited_users.size <=> a.favorited_users.size}}
end
