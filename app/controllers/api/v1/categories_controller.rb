class Api::V1::CategoriesController < ApplicationController

  before_action :authenticate_request
  before_action :set_category, only: [:show, :update, :destroy]

  def index
    @categories = Category.where(user_id: current_user.id)
    render json: @categories
  end

  def show
    render json: @category
  end

  def create
    @category = Category.new(category_params)
    @category.user_id = current_user.id
    if @category.save
      render json: @category, status: :created
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

   def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    render json: @category
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :category_type)
  end
end