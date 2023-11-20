require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "get_type() returns 'DraftPost' when published_at is nil" do
    assert (Post::get_type nil) == DraftPost.class.name
  end

  test "get_type() returns 'PublishedPost' when published_at is in the past or present" do
    assert (Post::get_type Date.yesterday) == PublishedPost.class.name
    assert (Post::get_type Time.current) == PublishedPost.class.name
  end

  test "get_type() returns 'ScheduledPost' when published_at is in the future" do
    assert (Post::get_type Date.tomorrow) == ScheduledPost.class.name
  end
end
