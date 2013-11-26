class RecommendationMailer < ActionMailer::Base
  default from: "admin@goodlistens.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.recommendation_mailer.recommend.subject
  #
  def recommend(user, recommends)
    @greeting = "Hi"
    @user = user
    @recommends = recommends
    mail to: user.email
  end
end
