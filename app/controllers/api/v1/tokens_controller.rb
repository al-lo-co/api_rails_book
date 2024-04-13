class Api::V1::TokensController < ApplicationController
  def create
    user = User.find_by(email: user_params[:email])
    if user.authenticate(user_params[:password])
      render json: {
        token: JWT.encode({ user_id: user.id }, user_params[:password]),
        email: user.email
      }
    else
      head :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
