class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :post_id, uniqueness: {scope: :user_id}
end
