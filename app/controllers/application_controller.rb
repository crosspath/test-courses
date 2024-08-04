class ApplicationController < ActionController::API
  include CrudActions

  private

  def render_error(message:, object: nil, errors: nil)
    errors ||= object.errors if object.respond_to?(:errors)

    render json: {error: {errors:, message:, object:}}, status: :unprocessable_entity
  end
end
