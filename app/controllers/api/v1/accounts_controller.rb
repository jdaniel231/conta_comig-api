class Api::V1::AccountsController < ApplicationController
  before_action :authenticate_request
  before_action :set_account, only: [:show, :update, :destroy]

  def index
    @accounts = Account.where(user_id: current_user.id)
                       .page(params[:page])
                       .per(params[:per_page] || 25)

    render json:{
      accounts: @accounts,
      meta: {
        current_page: @accounts.current_page,
        next_page: @accounts.next_page,
        prev_page: @accounts.prev_page,
        total_pages: @accounts.total_pages,
        total_count: @accounts.total_count
      }
    } 
  end

  def show
    render json: @account
  end

  def create
    @account = Account.new(account_params)
    @account.user_id = current_user.id
    if @account.save
      render json: @account, status: :created
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end
 
  def update
    if @account.update(account_params)
      render json: @account
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end
      
  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    render json: @account
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.permit(:name)
  end
end