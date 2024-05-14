class Api::V1::ProductsController < ApplicationController
  include Paginable

  before_action :set_product, only: %i[show update destroy]
  before_action :check_login, only: %i[create]
  before_action :check_owner, only: %i[update destroy]
  #before_action :cache_products, only: [:index] caching

  def index
    @products = Product.includes(:user)
                        .page(params[:page])
                        .per(params[:per_page])
                        .search(params)
    #query = Product.ransack(params[:q])
    #products = query.result(distinct: true)

    render json: ProductBlueprint.render(@products, view: :extended), status: :ok
  end

  def show
    render json: ProductBlueprint.render(@product, view: :extended) 
  end

  def create
    product = current_user.products.build(product_params)
    if product.save
      render json: ProductBlueprint.render(product, view: :extended), status: :created
    else
      render json: { errors: product.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: ProductBlueprint.render(@product, view: :extended), status: :ok
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy

    head 204
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :published, :page, :per_page)
  end

  def set_product
    @product ||= Product.find(params[:id])
  end

  def check_owner
    head :forbidden unless  @product.user_id == current_user&.id
  end

  def cache_products
    cache_key = "products/#{params[:page]}-#{params[:per_page]}-#{params.to_query}"

    @products = Rails.cache.fetch(cache_key, expires: 1.day) do
      Product.page(params[:page])
            .per(params[:per_page])
            .search(params)
    end
  end
end
