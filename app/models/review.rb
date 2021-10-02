class Review < ApplicationRecord
  belongs_to :dog
  validates :rating, :content, presence: true
  validates :content, length: { minimum: 20 }
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 0..5, message: "must be between O and 5" }
end
