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

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
