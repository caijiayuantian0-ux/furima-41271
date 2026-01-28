class GoodsController < ApplicationController

  def index
  end

  def new
    @good = Good.new
  end

  def create
  # パラメータの内容を確認
  puts "====== 全パラメータ ======"
  puts params.inspect
  puts "========================="
  
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