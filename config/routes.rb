# frozen_string_literal: true

BadgeMaker::Engine.routes.draw do
  get "/badges" => "badges#index", as: :badges
end

Discourse::Application.routes.draw do
  mount ::BadgeMaker::Engine, at: "/badge-maker"
end
