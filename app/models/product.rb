class Product < ApplicationRecord
  validates :title, :user_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :orders, through: :placements

  scope :filter_by_title, -> (title) { where("title ILIKE ?", "%#{title}%")}
  scope :below_or_equal_to_price, -> (price) { where("price <= ?", price)}
  scope :recent, -> { order(:updated_at) }

  def self.search(params = {})
    products = params[:product_ids].present? ? Product.where(id: params[:products_ids]) : Product.all

    products = products.filter_by_title(params[:keyword]) if params[:keyword].present?
    products = products.below_or_equal_to_price(params[:max_price]) if params[:max_price].present?
    products = products.recent if params[:recent].present?

    products
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "price", "published", "title", "updated_at", "user_id"]
  end
end
