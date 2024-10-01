# frozen_string_literal: true

module BadgeMaker
  class BadgeAssignmentJob < ::Jobs::Base
    def execute(args)
      user = User.find(args[:user_id])
      assign_badges(user)
    end

    private

    def assign_badges(user)
      assign_badge_based_on_email(user)
      assign_top_contributor_badges
      assign_badge_based_on_role(user)
      assign_badge_based_on_auth(user)
      assign_badge_based_on_answers(user)
    end

    # Implement the badge assignment logic here
  end
end
