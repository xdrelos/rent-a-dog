class Renting < ApplicationRecord
  belongs_to :user
  belongs_to :dog
  validates :status, inclusion: { in: %w(Pending Accepted Declined),
    message: "%{status} is not a valid value" }
  validates :number_of_hours, inclusion: { in: 1..24,
    message: "must be between 1 and 24" }
  validates :date, :number_of_hours, presence: true
  validate :date_after_current_date

  private

  def date_after_current_date
    return if date.blank?

    if date < Date.today
      errors.add(:date, "must be after today")
    end
 end
end
