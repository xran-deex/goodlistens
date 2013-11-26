require 'test_helper'

class RecommendationMailerTest < ActionMailer::TestCase
  test "recommend" do
    mail = RecommendationMailer.recommend
    assert_equal "Recommend", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
