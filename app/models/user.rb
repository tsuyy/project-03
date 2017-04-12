class User < ApplicationRecord
  has_secure_password
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "http://www.ameristarcoil.com/Other/ameristarcoilCOM/imgs/placeholder_user.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  has_many :entries, dependent: :destroy
  has_many :comments

  validates :name, :presence => true, length: { maximum: 255 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
