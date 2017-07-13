class Artwork < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :image_url, presence: true, uniqueness: true
  validates :artist_id, presence: true, uniqueness: true


  belongs_to(
  :artist,
  primary_key: :id,
  foreign_key: :artist_id,
  class_name: "User"
  )

  has_many :artwork_shares

  has_many(
  :shared_viewers,
  through: :artwork_shares,
  source: :viewer
  )
end
