class Post < ApplicationRecord
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

  scope :draft, -> { DraftPost.all }
  scope :published, -> { PublishedPost.all }
  scope :scheduled, -> { ScheduledPost.all }

  def self.get_type(published_at)
    case
    when published_at == nil
      DraftPost.name
    when published_at <= Time.current
      PublishedPost.name
    else
      ScheduledPost.name
    end
  end
end
