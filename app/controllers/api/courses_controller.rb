class API::CoursesController < ApplicationController
  self.model = Course
  self.serializer = CourseSerializer

  private

  def object_params
    params.permit(:name, :author_id, :competence_ids)
  end
end
