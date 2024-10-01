# frozen_string_literal: true

module BadgeMaker
  class Badge < ActiveRecord::Base
    self.table_name = "badge_maker_badges"  # Or "badges" if using core Discourse table

    validates :name, presence: true
    validates :description, presence: true
    validates :criteria, presence: true
  end
end
