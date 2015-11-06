class User < ActiveRecord::Base
  has_secure_password
    validates :name , length: { maximum: 20 } , presence: true
    validates :place , length: { maximum: 20 } , presence: true, on: :update
    validates :profile , length: { minimum: 2 , maximum: 30 } , presence: true, on: :update
    validates :email, presence: true, uniqueness: { case_sensitive: false }
end