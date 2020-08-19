class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :travel
  validates :date, uniqueness: {scope: :user}
end
