class BadgesController < ApplicationController
  def index
    @badges = Badge.all
    render json: @badges
  end

  def create
    badge = Badge.new(badge_params)
    if badge.save
      render json: badge, status: :created
    else
      render json: badge.errors, status: :unprocessable_entity
    end
  end

  def show
    badge = Badge.find(params[:id])
    render json: badge
  end

  private

  def badge_params
    params.require(:badge).permit(:name, :description)
  end
end
