class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates :name, presence: true
  before_create :generate_api_key
  has_secure_password


  def generate_api_key(attempt_count = 0)
    self.api_key = SecureRandom.hex(20)
    if User.exists?(api_key: self.api_key)
      while attempt_count <= 10
        generate_api_key(attempt_count + 1)
      end 
    end
  end
end