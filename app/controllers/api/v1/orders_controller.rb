class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index show create]

  def index
    render json: OrderBlueprint.render(current_user.orders, view: :extended)
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
    order = current_user.orders.build(order_params)

    if order.save
      OrderMailer.send_confirmation(order).deliver
      render json: OrderBlueprint.render(order, view: :extended), status: :created
    else
      render json: { errors: order.errors }, status: 422
    end
  end

  private

  def order_params
    params.require(:order).permit(:total, product_ids: [])
  end
end
