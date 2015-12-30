class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates_presence_of :name, :email, :password
  validates :name, length: { maximum: 50 }
  validates :password, length: { minimum: 6 }
  validates :email, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
                    uniqueness: { case_sensitive: false }
  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
