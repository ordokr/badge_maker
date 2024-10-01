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

    def assign_badge_based_on_email(user)
      if user.email.ends_with?("@domain.com")
        badge = Badge.find_by(name: "Domain Badge")
        assign_badge(user, badge) if badge
      end
    end

    def assign_top_contributor_badges
      top_contributors = User.joins(:posts)
                             .group("users.id")
                             .order("COUNT(posts.id) DESC")
                             .limit(X) # Replace X with the number of top contributors you want
      top_contributors.each do |contributor|
        badge = Badge.find_by(name: "Top Contributor")
        assign_badge(contributor, badge) if badge
      end
    end

    def assign_badge_based_on_role(user)
      if user.has_trust_level?(4) # Community superstar role
        badge = Badge.find_by(name: "Community Superstar")
        assign_badge(user, badge) if badge
      end
    end

    def assign_badge_based_on_auth(user)
      if user.auth_method == "twitter" # Adjust this based on your auth methods
        badge = Badge.find_by(name: "Twitter Sign-Up")
        assign_badge(user, badge) if badge
      end
    end

    def assign_badge_based_on_answers(user)
      answered_questions = user.posts.where(topic_id: specific_topic_id) # Adjust for the subject/topic
      if answered_questions.count >= X # Replace X with the required number of answers
        badge = Badge.find_by(name: "Answering Guru")
        assign_badge(user, badge) if badge
      end
    end

    def assign_badge(user, badge)
      # Logic to assign the badge to the user
      if badge.present?
        # This is where you would create the relationship or whatever method you have to award the badge
        BadgeUser.create!(user: user, badge: badge)
      end
    end
  end
end
