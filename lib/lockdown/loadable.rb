class Loadable

  def initialize(name, controller)
    @name = name.to_s
    @controller = controller
  end

  def model
    getter.classify.constantize
  end

  def getter
    if singular?
      @name
    else
      @name.pluralize
    end
  end

  def singular?
    @controller.params.include? :id
  end

end