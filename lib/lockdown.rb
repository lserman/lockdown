require 'lockdown/version'
require 'lockdown/loadable'
require 'lockdown/loader'

require 'active_support/all'

module Lockdown
  extend ActiveSupport::Concern

  def preload(name = nil, &block)
    name ||= controller_name.singularize
    loadable = Loadable.new(name, self)
    resource = Loader.new(loadable, self).resolve(&block)
    instance_variable_set "@#{loadable.getter}", resource
  end

  # def lockdown(authorizer)
  #   @inference ||= Inference.new(:infer)
  #   authorizer.call current_user, resource, params[:action]
  # end

  module ClassMethods

    def preload(*name, &block)
      options = name.extract_options!
      send(:before_action) { |controller| controller.preload(name.first, &block) }
    end

    # def lockdown(authorizer = :infer)
    #   send(:before_filter) { |controller| controller.lockdown(authorizer) }
    # end

  end

end