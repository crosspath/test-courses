class Course < ApplicationRecord
  belongs_to :author

  has_many :courses_competences
  has_many :competences, through: :courses_competences
end
