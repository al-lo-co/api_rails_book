class Api::V1::OrdersController < ApplicationController
  include Paginable

  before_action :check_login, only: %i[index show create]

  def index
    orders = current_user.orders.page(params[:page]).per(params[:per_page])

    render json: OrderBlueprint.render(orders, view: :extended)
  end

  def show
    order = current_user.orders.find(params[:id])

    if order
      render json: OrderBlueprint.render(order, view: :extended)
    else
      head 404
    end
  end

  def create
    order = Order.create!(user_id: current_user.id)
    order.build_placements_with_product_ids_and_quantities(order_params[:product_ids_and_quantities])

    if order.save
      OrderMailer.send_confirmation(order).deliver
      render json: OrderBlueprint.render(order, view: :extended), status: :created
    else
      render json: { errors: order.errors }, status: 422
    end
  end

  private

  def order_params
    #params.require(:order).permit(:total, product_ids: [])
    params.require(:order).permit(product_ids_and_quantities: [:product_id, :quantity])
  end
end
