require 'dry/effects'

class CounterMiddleware
  include Dry::Effects::Handler.State(:counter)

  def initialize(app)
    @app = app
  end

  def call(env)
    counter, response = with_counter(41) do
      @app.(env)
    end

    response
  end
end

class CreatePost
  include Dry::Effects.State(:counter)

  def call(values)=begin  =end
    self.counter += 1
  end
end

middleware = CounterMiddleware.new(CreatePost.new)
p middleware.call({})