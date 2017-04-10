class Entry < ApplicationRecord
  belongs_to :user
  has_attached_file :avatar, styles: { medium: "300x300>", large: "1000x1000>" }, default_url: "assets/images/doge-default.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
