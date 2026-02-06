class PurchasesController < ApplicationController
  before_action :set_good
  before_action :authenticate_user!
  before_action :move_to_root, only: [ :create]
  before_action :redirect_if_sold

  def index
    @purchase = PurchaseForm.new
  end

  def create
    @purchase = PurchaseForm.new(purchase_params)
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

  def redirect_if_sold
    if @good.purchase.present?
      redirect_to root_path
    end
  end

  def purchase_params
    params.require(:purchase_form).permit(
      :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number
    ).merge(
      user_id: current_user.id,
      good_id: @good.id
    )
  end

  def move_to_root
    if current_user.id == @good.user_id || @good.purchase.present?
      redirect_to root_path
    end
  end
end
