class Renting < ApplicationRecord
  belongs_to :user
  belongs_to :dog
  validates :status, inclusion: { in: %w(Pending Accepted Declined),
    message: "%{status} is not a valid value" }
end
