require 'set'

require "fake_rails3_routes/version"

module FakeRails3Routes
  def self.draw(&block)
    if Rails.version >= "3.0"
      # we're on rails 3, no need to emulate
      Rails.application.class.routes.draw(&block)
    else
      @route_set ||= FakeRails3Routes::RouteSet.new
      @route_set.draw(block)
    end
  end

  class RouteSet
    attr_reader :map
    def draw(block)
      require 'fake_rails3_routes/mapper'
      require 'journey'
      ActionController::Routing::Routes.draw do |map|
        @map = map
        @named_routes = Set.new
        mapper = FakeRails3Routes::Mapper.new(self)
        mapper.instance_exec(&block)
      end
    end

    def add_route(conditions = {}, requirements = {}, defaults = {}, name = nil, anchor = true)
      defaults = defaults.merge(requirements)
      path = conditions.delete(:path_info)
      if name == 'root'
        @map.send(name, defaults)
      elsif name
        @map.named_route(name, path, defaults)
        @named_routes << name
      else
        @map.connect(path, defaults)
      end
    end

    def named_route?(name)
      !!(name && @map.instance_variable_get(:@set).named_routes.get(name))
    end
  end
end
