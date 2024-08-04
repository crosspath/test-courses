# frozen_string_literal: true

# Generic code for RESTful services.
module CrudActions
  # @param base [ApplicationController]
  def self.included(base)
    base.class_eval do
      cattr_accessor(:model, :serializer, instance_writer: false)

      before_action(:find_object, only: %i[destroy show update])
    end
  end

  # POST /{objects}
  def create
    object = model.new(object_params)
    return render_object(object) if object.save

    render_error("Failed to create #{model.name}", object:)
  end

  # DELETE /{objects}/{id}
  # @yield Use block for destroying object
  # @yieldreturn [Boolean]
  def destroy
    if block_given? ? yield : object.destroy # rubocop:disable Rails/SaveBang False detection
      return render_object(object)
    end

    render_error("Failed to delete #{model.name}", object:)
  end

  # GET /{objects}
  def index
    render_objects(model.order(:id))
  end

  # GET /{objects}/{id}
  def show
    render_object(object)
  end

  # PUT or PATCH /{objects}/{id}
  def update
    object.attributes = object_params
    return render_object(object) if object.save

    render_error("Failed to update #{model.name}", object:)
  end

  private

  attr_reader :object

  # Find record by ID and store it in instance variable `@object`.
  def find_object
    @object = model.find_by(id: params[:id])
    render_error("Cannot find #{model.name}") unless object
  end

  # New data for `create` and `update` actions.
  def object_params
    raise NotImplementedError
  end

  # Return response with error objects.
  def render_error(message, object: nil, errors: nil)
    errors ||= object.errors if object.respond_to?(:errors)

    render json: {error: {errors:, message:, object:}}, status: :unprocessable_entity
  end

  # Return response with requested object.
  def render_object(object)
    render json: {object: serializer.render_as_hash(object)}
  end

  # Return response with requested objects.
  def render_objects(objects)
    render json: {objects: serializer.render_as_hash(objects)}
  end
end
