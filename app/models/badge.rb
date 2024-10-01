# frozen_string_literal: true

class Badge < ApplicationRecord
  # Assuming you have attributes like name and description
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
