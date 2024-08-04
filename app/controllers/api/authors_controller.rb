# frozen_string_literal: true

# /api/authors
class API::AuthorsController < ApplicationController
  self.model = Author
  self.serializer = AuthorSerializer

  # Run checks before destroying object.
  def destroy
    super { Authors::Delete.call(object) }
  rescue Authors::Delete::LastAuthorError => e
    render_error(e.message, object:)
  end

  private

  def object_params
    params.permit(:name)
  end
end
