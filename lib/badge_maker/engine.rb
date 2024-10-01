# frozen_string_literal: true

module BadgeMaker
  class Engine < ::Rails::Engine
    engine_name "badge_maker"
    
    isolate_namespace BadgeMaker
    
    initializer "badge_maker.initialize" do |app|
      # Custom initialization code (if needed) can be added here.
    end
  end
end
