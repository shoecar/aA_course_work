class TagTopic < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_many(
    :taggings,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: :Tagging
  )

  has_many(
    :shortened_urls,
    through: :taggings,
    source: :short_url
  )
end
