class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  belongs_to :user
  has_many :comments

  self.per_page = 8

  mount_uploader :image, ImgPostUploader

end
