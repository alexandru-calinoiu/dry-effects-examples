require 'dry/effects'

class TestNewFeatureMiddleware
  include Dry::Effects::Handler.Cmp(:feature, as: :test_feature)

  def initialize(app)
    @app = app
  end

  def call(env)
    without_feature, with_feature = test_feature do
      @app.call(env)
    end

    if with_feature != without_feature
    end

    without_feature
  end
end

class PostView
  include Dry::Effects.Cmp(:feature)

  def call(_args)
    if feature?
      'test feature is enabled'
    else
      'test feature is disabled'
    end
  end
end

middleware = TestNewFeatureMiddleware.new(PostView.new)
p middleware.call({})
