# frozen_string_literal: true

# name: badge maker
# about: A plugin to manage badges in Discourse.
# version: 0.1.0
# authors: Your Name
# url: https://github.com/yourusername/badge_maker

enabled_site_setting :badge_maker_enabled

module BadgeMaker
  class Engine < ::Rails::Engine
    engine_name "badge_maker"
    isolate_namespace BadgeMaker
  end
end

require_relative "lib/badge_maker/engine"

after_initialize do
  # Code which should run after Rails has finished booting
end
