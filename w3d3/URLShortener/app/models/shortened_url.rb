class ShortenedUrl < ActiveRecord::Base
  validates :long_url, uniqueness: true, presence: true, 
  validates :short_url, uniqueness: true, presence: true
  validates :submitter_id, presence: true

  belongs_to(
    :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: :User
  )

  has_many(
    :visits,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :Visit
  )

  has_many(
    :visitors,
    -> { distinct },
    through: :visits,
    source: :user
  )

  has_many(
    :taggings,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: :Tagging
  )

  has_many(
  :tag_topics,
  through: :taggings,
  source: :tag_topic
  )

  def self.random_code
    code = nil
    until code && !ShortenedUrl.exists?(code)
      code = SecureRandom::urlsafe_base64
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(long_url: long_url,
      submitter_id: user.id,
      short_url: ShortenedUrl.random_code)
  end

  def self.short_to_long(short_url)
    ShortenedUrl.select(:long_url).where("short_url = ?", short_url).first[:long_url]
  end

  def num_clicks
    self.visits.length
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visits.select(:created_at, :user_id).distinct.where("created_at > ?", 10.years.ago ).count
  end
end
