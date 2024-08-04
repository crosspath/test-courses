# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
