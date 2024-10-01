# frozen_string_literal: true

module BadgeMaker
  class Badge < ActiveRecord::Base
    self.table_name = "badges"

    validates :name, presence: true
    validates :description, presence: true
    validates :criteria, presence: true
  end
end
