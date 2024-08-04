# frozen_string_literal: true

# Author of any course.
class Author < ApplicationRecord
  has_many :courses, dependent: :restrict_with_error

  validates :name, presence: true
end
