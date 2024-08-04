class Author < ApplicationRecord
  has_many :courses, dependent: :restrict_with_error

  validates :name, presence: true
end
