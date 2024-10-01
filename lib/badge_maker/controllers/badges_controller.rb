# frozen_string_literal: true

module BadgeMaker
  class BadgesController < ::ApplicationController
    def index
      @badges = Badge.all
      render :index
    end
  end
end
