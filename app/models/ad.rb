class Ad < ActiveRecord::Base

  # Constants
    QTT_PER_PAGE = 6

  belongs_to :category
  belongs_to :member

  #Scopes
  scope :descending_order, ->(quantity = 10) { limit(quantity).order(created_at: :desc)}
  scope :to_the, ->(member) { where(member: member) }

  #paperclip
  has_attached_file :picture, styles: { large: "800x300#", medium: "320x150#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  #gem money-rails
  monetize :price_cents
end
