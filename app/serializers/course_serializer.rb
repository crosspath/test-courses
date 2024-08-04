# frozen_string_literal: true

class CourseSerializer < Blueprinter::Base
  fields :id, :name, :author_id, :competence_ids

  association :author, blueprint: AuthorSerializer
  association :competences, blueprint: CompetenceSerializer
end
