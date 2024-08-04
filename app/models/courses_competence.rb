# frozen_string_literal: true

# Linking table for courses & competences.
class CoursesCompetence < ApplicationRecord
  belongs_to :course
  belongs_to :competence
end
