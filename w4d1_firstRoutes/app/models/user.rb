class User < ApplicationRecord

  validates :name, presence: true

  has_many(
  :artworks,
  primary_key: :id,
  foreign_key: :artist_id,
  class_name: "Artwork"
  )

  has_many(
  :shared_artworks,
  through: :shared_viewers,
  source: :artist
  )


end
