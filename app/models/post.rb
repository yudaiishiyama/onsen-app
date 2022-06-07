class Post < ApplicationRecord
  validates :address, presence: true
  validates :spring_quality, presence: true
  validates :description, presence: true
  validates :image, presence: true

  belongs_to :user
  has_one_attached :image
end
