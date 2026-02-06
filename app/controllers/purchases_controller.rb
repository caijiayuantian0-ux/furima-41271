class PurchasesController < ApplicationController

  def index 
    @purchase = Purchase.new
  end

  def create
     @purchase = Purchase.new(purchase_params)

    if @purchase.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_good
    @good = Good.find(params[:good_id])
  end

  def purchase_params
    params.require(:purchases).permit(
      :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number
    ).merge(
      user_id: current_user.id,
      good_id: @good.id
    )
  end

end
