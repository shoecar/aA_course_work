class Comment < ActiveRecord::Base
  validates :content, presence: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true

  belongs_to(
    :commentable,
    polymorphic: true
  )

end
