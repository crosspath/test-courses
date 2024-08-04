module CrudActions
  # @param base [ApplicationController]
  def self.included(base)
    base.class_eval do
      thread_cattr_accessor(:model, :serializer, instance_writer: false)

      before_action :find_object, only: %i[destroy show update]
    end
  end

  def create
    object = model.new(object_params)
    return render(json: serializer.render(object)) if object.save

    render_error("Failed to create #{model.name}", object:)
  end

  # @yield Use block for destroying object
  # @yieldreturn [Boolean]
  def destroy
    return render(json: serializer.render(object)) if block_given? ? yield : object.destroy

    render_error("Failed to delete #{model.name}", object:)
  end

  def index
    objects = model.all
    render(json: serializer.render(objects))
  end

  def show
    render(json: serializer.render(object))
  end

  def update
    object.attributes = object_params
    return render(json: serializer.render(object)) if object.save

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
end
