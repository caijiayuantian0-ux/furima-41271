class GoodsController < ApplicationController



  private 

  def goods_params
    params.require(:goods).permit(:name,
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
