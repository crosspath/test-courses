class Competence < ApplicationRecord
  has_many :courses_competences
  has_many :courses, through: :courses_competences

  validates :name, presence: true
end
