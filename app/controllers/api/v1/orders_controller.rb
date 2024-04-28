class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index]

  def index
    render json: OrderBlueprint.render(current_user.orders)
  end
end