# lib/badge_maker/jobs/badge_assignment_job.rb

class BadgeAssignmentJob < ApplicationJob
  queue_as :default

  def perform(user)
    assign_badge_based_on_email(user)
    assign_monthly_top_contributors
    assign_superstar_badge(user)
    assign_badge_for_twitter_signup(user)
    assign_badge_for_answering_questions(user)
  end

  private

  def assign_badge_based_on_email(user)
    if user.email.ends_with?("@domain.com")
      badge = Badge.find_by(name: "Domain Badge")
      user.badges << badge if badge
    end
  end

  def assign_monthly_top_contributors
    top_contributors = User.order('score DESC').limit(10) # Replace score with actual points
    badge = Badge.find_by(name: "Top Contributor")

    top_contributors.each do |user|
      user.badges << badge if badge
    end
  end

  def assign_superstar_badge(user)
    if user.has_role?("community_superstar")
      badge = Badge.find_by(name: "Community Superstar")
      user.badges << badge if badge
    end
  end

  def assign_badge_for_twitter_signup(user)
    if user.authentications.any? { |auth| auth.provider == "twitter" }
      badge = Badge.find_by(name: "Twitter Sign-up")
      user.badges << badge if badge
    end
  end

  def assign_badge_for_answering_questions(user)
    answered_questions_count = Post.where(user_id: user.id, topic_id: Category.find_by(name: 'Specific Subject').topics).count

    if answered_questions_count >= 10
      badge = Badge.find_by(name: "Question Expert")
      user.badges << badge if badge
    end
  end
end
