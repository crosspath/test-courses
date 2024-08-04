class CoursesCompetence < ApplicationRecord
  belongs_to :course
  belongs_to :competence
end
