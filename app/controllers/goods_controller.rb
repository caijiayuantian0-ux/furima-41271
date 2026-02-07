class GoodsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_good, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold, only: [:edit, :update]
  def index
    @goods = Good.includes(:user).order(created_at: :desc)
  end

  def new
    @good = Good.new
  end

  def create
    @good = Good.new(good_params)

    if @good.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @good.update(good_params)
      redirect_to good_path(@good)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @good.destroy
    redirect_to root_path
  end
  
  private
  
  def set_good
    @good = Good.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless current_user.id == @good.user_id
  end

  def good_params
    params.require(:good).permit(
      :name,
      :description,
      :category_id,
      :condition_id,
      :shipping_fee_id,
      :prefecture_id,
      :days_to_ship_id,
      :price,
      :image
    ).merge(user_id: current_user.id)
  end

  def redirect_if_sold
    if @good.purchase.present?
      redirect_to root_path
    end
  end
end
