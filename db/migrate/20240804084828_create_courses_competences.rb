# frozen_string_literal: true

class CreateCoursesCompetences < ActiveRecord::Migration[7.1]
  def change
    create_table :courses_competences do |t|
      t.references :course, null: false, foreign_key: true
      t.references :competence, null: false, foreign_key: true

      t.index %i[course_id competence_id], unique: true, name: "uniq"

      t.timestamps
    end
  end
end
