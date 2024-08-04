class API::AuthorsController < ApplicationController
  self.model = Author
  self.serializer = AuthorSerializer

  private

  def object_params
    params.permit(:name)
  end
end
