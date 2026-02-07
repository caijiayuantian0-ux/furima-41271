class PurchasesController < ApplicationController
<<<<<<< Updated upstream
  before_action :set_good, only: [ :index, :create]
  before_action :authenticate_user!, only: [ :index, :create]
  before_action :move_to_root, only: [ :index, :create]
  before_action :redirect_if_sold, only: [ :index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase = PurchaseForm.new
  end

  def create
    @purchase = PurchaseForm.new(purchase_params)
    if @purchase.valid?
      pay_item
      @purchase.save
=======
  before_action :authenticate_user!
  before_action :set_good
  
  def index
    @shipping_address_purchase = ShippingAddressPurchase.new
  end
  
  def create
    @shipping_address_purchase = ShippingAddressPurchase.new(shipping_address_purchase_params)
    if @shipping_address_purchase.valid?
      @shipping_address_purchase.save
>>>>>>> Stashed changes
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end
<<<<<<< Updated upstream

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
      good_id: @good.id,
      token: params[:token]
    )
  end

  def move_to_root
    if current_user.id == @good.user_id || @good.purchase.present?
      redirect_to root_path
    end
  end

  def pay_item
    good = Good.find( purchase_params[:good_id])

      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: good.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
=======
  
  private
  
  def set_good
    @good = Good.find(params[:good_id])
  end
  
  def shipping_address_purchase_params
    params.require(:shipping_address_purchase).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number, :token).merge(user_id: current_user.id, good_id: @good.id, token: params[:token])
>>>>>>> Stashed changes
  end
end