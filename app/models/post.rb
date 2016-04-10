class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true
  belongs_to :user
  has_many :comments
  ratyrate_rateable "body"

  self.per_page = 8

  mount_uploader :image, ImgPostUploader

  scope :order_asc, -> { order("created_at ASC", "title ASC") }


  def self.search(search, page)
    if search
       where("title LIKE ? ", "%#{search}%").page(page)
    else
      page(page)
    end
  end

  def self.import(file, user)
    CSV.foreach(file.path, headers: true) do |row|

      post = find_by_id(row["id"]) || new
      parameters = ActionController::Parameters.new(row.to_hash.merge(:user_id => user.id))
      post.update(parameters.permit(:id,:title,:body,:user_id))
      post.save!
      #Post.create! row.to_hash.merge(:user_id => user.id)
    end
  end

end
