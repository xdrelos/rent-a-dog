class Review < ApplicationRecord
  belongs_to :dog
  belongs_to :user
  validates :rating, :content, presence: true
  validates :content, length: { minimum: 20 }
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 1..5, message: "must be between O and 5" }
end
