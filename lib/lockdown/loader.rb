class Loader

  attr_accessor :loadable, :controller

  def initialize(loadable, controller)
    @loadable = loadable
    @controller = controller
  end

  def resolve(&block)
    if loadable.singular?
      find(controller.params[:id], &block)
    else
      collection
    end
  end

  private

    def find(id, &block)
      if block
        yield
      else
        loadable.model.find(id)
      end
    end

    def collection
      loadable.model.all
    end

end