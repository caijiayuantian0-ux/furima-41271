class PurchasesController < ApplicationController
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
  end
end