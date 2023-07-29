class Genre < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :characterizations
  has_many :movies, through: :characterizations
end
