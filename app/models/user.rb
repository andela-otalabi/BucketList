class User < ActiveRecord::Base
 has_secure_password
  before_create :generate_auth_token
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true

  has_many :bucketlists

  def generate_auth_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end
end
