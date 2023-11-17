class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  scope :draft, -> { DraftPost.all }
  scope :published, -> { PublishedPost.all }
  scope :scheduled, -> { ScheduledPost.all }

  def self.get_type(published_at)
    case
    when published_at == nil
      "DraftPost"
    when published_at <= Time.current
      "PublishedPost"
    else
      "ScheduledPost"
    end
  end
end
