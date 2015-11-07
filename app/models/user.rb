class User < ActiveRecord::Base
  has_secure_password
    validates :name , length: { maximum: 20 } , presence: true
    validates :place , length: { maximum: 20 } , presence: true, on: :update
    validates :profile , length: { minimum: 2 , maximum: 30 } , presence: true, on: :update
    validates :email, presence: true, uniqueness: { case_sensitive: false }
    has_many :microposts
    has_many :follower_relationships, class_name:  "Relationship",
                                      foreign_key: "followed_id",
                                      dependent:   :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower
    
  # 他のユーザーをフォローする
  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end

  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
    following_users.include?(other_user)
  end
end