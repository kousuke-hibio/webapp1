class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many :images, dependent: :destroy 
  accepts_nested_attributes_for :images,
  allow_destroy: true
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user 

  def Post.search(search, user_or_post)
    if user_or_post == "2"
      Post.where(['title LIKE ?', "%#{search}%"])
    else
      Post.all 
    end 
  end 
end
