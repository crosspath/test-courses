# frozen_string_literal: true

# /api/courses
class API::CoursesController < ApplicationController
  self.model = Course
  self.serializer = CourseSerializer

  private

  def object_params
    res = params.permit(:name, :author_id, :competence_ids)
    res[:competence_ids] = res[:competence_ids].split(",") if res[:competence_ids].is_a?(String)
    res
  end
end
