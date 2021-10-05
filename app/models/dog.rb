class Dog < ApplicationRecord
  belongs_to :user
  validates :name, :breed, :description, :age, :city, :price_per_hour, presence: true
  has_one_attached :profile_picture
  has_many_attached :pictures
  has_many :rentings
  has_many :reviews, dependent: :destroy
  belongs_to :breed
  include PgSearch::Model

  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_city?

  pg_search_scope :global_search,
    against: [ :name, :description, :city ],
    associated_against: { breed: :name },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
