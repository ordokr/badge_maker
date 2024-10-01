# frozen_string_literal: true

# name: badge-maker
# about: A plugin to award badges based on user achievements
# version: 0.1.0
# authors: Your Name
# url: http://yourpluginurl.com
# required_version: 2.7.0

enabled_site_setting :badge_maker_enabled

require_relative "lib/badge_maker/engine"

after_initialize do
  # Any code to run after Discourse has finished booting
end
