class Dog < ApplicationRecord
  belongs_to :user
  validates :name, :breed, :description, :city, :price_per_hour, presence: true
  has_one_attached :profile_picture
  has_many_attached :pictures
  has_many :rentings
  include PgSearch::Model

  pg_search_scope :global_search,
    against: [ :name, :breed, :description, :city ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
