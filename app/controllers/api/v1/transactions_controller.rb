class Api::V1::TransactionsController < ApplicationController

  before_action :authenticate_request
  before_action :set_transaction, only: [:show, :update, :destroy]

  def index
    @transactions = Transaction.where(user_id: current_user.id)
    render json: @transactions
  end

  def show
    render json: @transaction
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user_id = current_user.id
    if @transaction.save
      render json: @transaction, status: :created
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    render json: @transaction
  end

  private

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:amout, :date, :description, :account_id, :category_id)
  end
end
