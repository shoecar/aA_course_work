class Tagging < ActiveRecord::Base
  validates :tag_topic_id, presence: true
  validates :shortened_url_id, presence: true

  belongs_to(
    :short_url,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :ShortenedUrl
  )

  belongs_to(
    :tag_topic,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: :TagTopic
  )

  def self.create_tag!(tag_topic, short_url)
    Tagging.create!(
      tag_topic_id: tag_topic.id,
      shortened_url_id: short_url.id
    )
  end
end
