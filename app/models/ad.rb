class Ad < ActiveRecord::Base
  belongs_to :category
  belongs_to :member

  has_attached_file :picture, styles: { large: "800x300#", medium: "320x150#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  
  #gem money-rails
  monetize :price_cents
end
