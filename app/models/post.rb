class Post < ApplicationRecord
  has_one_attached :cover_image
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true
  validates :cover_image, presence: true

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
