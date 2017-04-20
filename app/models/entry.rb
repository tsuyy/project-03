class Entry < ApplicationRecord
  belongs_to :user

  has_attached_file :avatar, styles: { medium: "300x300>", large: "1000x1000>" }, default_url: "",
        :storage => :cloudinary,
        :path    => ':id/:style/:filename'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  acts_as_commentable
  has_many :comments

  validates :user_id, presence: true
  validates :caption, presence: true, length: { maximum: 50 }
  validates :location, presence: true

end
