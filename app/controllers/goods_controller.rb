class GoodsController < ApplicationController
before_action :authenticate_user!, only: [:new, :create]

  def index
  end

  def new
    @good = Good.new
  end

  def create
  @good = Good.new(goods_params)
  
  if @good.save
    redirect_to root_path
  else
    render :new, status: :unprocessable_entity
  end
end

  private 

  def goods_params
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
end