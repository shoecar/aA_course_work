class User < ActiveRecord::Base
  has_many :cats

  has_many(
    :cat_rental_requests,
    through: :cats,
    source: :rental_requests
  )

  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password cannot be blank" }
  validates :password, length: { minimum: 6, allow_nil: true }
  attr_reader :password

  after_initialize :token_present

  def self.find_by_credentials(user_name, password)
    user = User.where(user_name: user_name).first
    if user.nil?
      nil
    elsif user.is_password?(password)
      user
    else
      nil
    end
  end

  def password=(new_password)
    self.password_digest = BCrypt::Password.create(new_password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    save
  end

  private

  def token_present
    self.session_token ||= reset_session_token!
  end

end
