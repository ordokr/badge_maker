# frozen_string_literal: true

BadgeMaker::Engine.routes.draw do
  resources :badges, only: [:index, :create, :show]
end

Discourse::Application.routes.draw do
  mount ::BadgeMaker::Engine, at: '/badge_maker', as: 'custom_badge_maker'
end
