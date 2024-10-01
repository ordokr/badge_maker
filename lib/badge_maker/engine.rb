# frozen_string_literal: true

module BadgeMaker
  class Engine < ::Rails::Engine
    engine_name "badge_maker"

    initializer "badge_maker.initialize" do |app|
      # Code that runs when the engine initializes
      app.config.paths["config/routes.rb"].concat(Dir["#{config.root}/config/routes.rb"])
    end
  end
end
