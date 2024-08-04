# frozen_string_literal: true

# Competence shows what student can get from a course.
class Competence < ApplicationRecord
  has_many :courses_competences, dependent: :delete_all
  has_many :courses, through: :courses_competences

  validates :name, presence: true
end
