module CrudActions
  # @param base [ApplicationController]
  def self.included(base)
    base.class_eval do
      thread_cattr_accessor(:model, :serializer, instance_writer: false)

      before_action(:find_object, only: %i[destroy show update])
    end
  end

  def create
    object = model.new(object_params)
    return render_object(object) if object.save

    render_error("Failed to create #{model.name}", object:)
  end

  # @yield Use block for destroying object
  # @yieldreturn [Boolean]
  def destroy
    return render_object(object) if block_given? ? yield : object.destroy

    render_error("Failed to delete #{model.name}", object:)
  end

  def index
    render_objects(model.all)
  end

  def show
    render_object(object)
  end

  def update
    object.attributes = object_params
    return render_object(object) if object.save

    render_error("Failed to update #{model.name}", object:)
  end

  private

  attr_reader :object

  def find_object
    @object = model.find_by(id: params[:id])
    render_error("Cannot find #{model.name}") unless object
  end

  def object_params
    raise NotImplementedError
  end

  def render_error(message, object: nil, errors: nil)
    errors ||= object.errors if object.respond_to?(:errors)

    render json: {error: {errors:, message:, object:}}, status: :unprocessable_entity
  end

  def render_object(object)
    render json: {object: serializer.render_as_hash(object)}
  end

  def render_objects(objects)
    render json: {objects: serializer.render_as_hash(objects)}
  end
end
