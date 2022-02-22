class Ripple < ApplicationRecord
  validates :name, :message, presence: true
end
