class Order < ApplicationRecord
  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements
  before_validation :set_total!

  validates :total, numericality: { greater_than_or_equal_to: 0 }, presence: true

  def set_total!
    #self.total = self.products.inject(0) { |sum, product| sum + product.price }
    self.total = Product.where(id: self.product_ids).sum(:price)
    #self.total = products.reload.sum(:price) sum method has changed for rails 7 in the eager loading data for intermediate tables so, this is not a solution
  end

  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      placement = self.placements.build(product_id: product_id_and_quantity[:product_id])
      yield placement if block_given?
    end
  end
end
