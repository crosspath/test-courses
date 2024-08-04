class API::CompetencesController < ApplicationController
  self.model = Competence
  self.serializer = CompetenceSerializer

  private

  def object_params
    params.permit(:name)
  end
end
