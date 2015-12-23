class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates_presence_of :name, :email
  validates :name, length: { maximum: 50 }
  validates :email, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},
                    uniqueness: { case_sensitive: false }
end
