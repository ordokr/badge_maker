# lib/badge_maker/jobs/badge_assignment_job.rb

class BadgeAssignmentJob < ApplicationJob
  queue_as :default

  BADGE_NAMES = {
    domain: "Domain Badge",
    top_contributor: "Top Contributor",
    superstar: "Community Superstar",
    twitter_signup: "Twitter Sign-up",
    question_expert: "Question Expert"
  }.freeze

  def perform(user)
    assign_badge_based_on_email(user)
    assign_monthly_top_contributors
    assign_superstar_badge(user)
    assign_badge_for_twitter_signup(user)
    assign_badge_for_answering_questions(user)
  end

  private

  def assign_badge_based_on_email(user)
    badge = Badge.find_by(name: BADGE_NAMES[:domain])
    return Rails.logger.warn("Badge '#{BADGE_NAMES[:domain]}' not found.") unless badge

    user.badges << badge unless user.badges.include?(badge)
  end

  def assign_monthly_top_contributors
    top_contributors = User.order('score DESC').limit(10)
    badge = Badge.find_by(name: BADGE_NAMES[:top_contributor])
    return Rails.logger.warn("Badge '#{BADGE_NAMES[:top_contributor]}' not found.") unless badge

    top_contributors.each do |user|
      user.badges << badge unless user.badges.include?(badge)
    end
  end

  def assign_superstar_badge(user)
    if user.has_role?("community_superstar")
      badge = Badge.find_by(name: BADGE_NAMES[:superstar])
      return Rails.logger.warn("Badge '#{BADGE_NAMES[:superstar]}' not found.") unless badge

      user.badges << badge unless user.badges.include?(badge)
    end
  end

  def assign_badge_for_twitter_signup(user)
    if user.authentications.any? { |auth| auth.provider == "twitter" }
      badge = Badge.find_by(name: BADGE_NAMES[:twitter_signup])
      return Rails.logger.warn("Badge '#{BADGE_NAMES[:twitter_signup]}' not found.") unless badge

      user.badges << badge unless user.badges.include?(badge)
    end
  end

  def assign_badge_for_answering_questions(user)
    specific_subject = Category.find_by(name: 'Specific Subject')
    return Rails.logger.warn("Category 'Specific Subject' not found.") unless specific_subject

    answered_questions_count = Post.where(user_id: user.id, topic_id: specific_subject.topics.pluck(:id)).count

    if answered_questions_count >= 10
      badge = Badge.find_by(name: BADGE_NAMES[:question_expert])
      return Rails.logger.warn("Badge '#{BADGE_NAMES[:question_expert]}' not found.") unless badge

      user.badges << badge unless user.badges.include?(badge)
    end
  end
end
