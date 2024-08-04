# frozen_string_literal: true

# Activity for teaching students.
class Course < ApplicationRecord
  belongs_to :author

  has_many :courses_competences, dependent: :delete_all
  has_many :competences, through: :courses_competences

  validates :name, presence: true
end
