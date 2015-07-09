class Visit < ActiveRecord::Base
  validates :short_url_id, presence: true
  validates :user_id, presence: true


  belongs_to(
    :short_url,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :ShortenedUrl
  )

  belongs_to(
    :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
  )

  def self.record_visit!(short_url, user)
    Visit.create!(
      short_url_id: short_url.id,
      user_id: user.id
    )
  end
end
