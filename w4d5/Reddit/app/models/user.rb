# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :name, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validate :ensure_session_token

  attr_reader :password

  has_many(
    :subs,
    foreign_key: :moderator_id,
    class_name: "Sub"
  )

  has_many :posts

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(name, password)
    @user = User.find_by(name: name)
    return nil if !@user
    @user.is_password?(password) ? @user : nil
  end

  def reset_session_token!
    token = generate_session_token
    self.session_token = token
    self.save
    token
  end

  private
  def generate_session_token
    SecureRandom.urlsafe_base64
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end
end
