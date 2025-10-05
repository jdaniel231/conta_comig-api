class Api::V1::AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id }, Rails.application.credentials.secret_key_base, 'HS256')
      render json: { token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def register
    @user = User.new(auth_params)
    if @user.save
      token = JWT.encode({ user_id: @user.id }, Rails.application.credentials.secret_key_base, 'HS256')
      render json: { token: token }
    else
      render json: { error: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def logout
    render json: { message: 'Logged out!' }
  end

  private

  def auth_params
    params.permit(:name, :email, :password)
  end
end