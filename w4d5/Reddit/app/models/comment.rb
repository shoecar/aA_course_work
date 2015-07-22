# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text             not null
#  user_id          :integer          not null
#  commentable_id   :integer          not null
#  commentable_type :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  validates :content, :user_id, :commentable_id, :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
end
