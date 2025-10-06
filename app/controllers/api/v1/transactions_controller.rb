class Api::V1::TransactionsController < ApplicationController

  before_action :authenticate_request
  before_action :set_transaction, only: [:show, :update, :destroy]

  def index
    @transactions = Transaction.where(user_id: current_user.id)
                        .page(params[:page])
                        .per(params[:per_page] || 25)


    render json: {
      transactions: @transactions,
      meta: {
        current_page: @transactions.current_page,
        next_page: @transactions.next_page,
        prev_page: @transactions.prev_page,
        total_pages: @transactions.total_pages,
        total_count: @transactions.total_count
      }
    }
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
