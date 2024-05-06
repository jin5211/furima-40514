class OrdersController < ApplicationController
  before_action :set_item
  before_action :sold_out?, only: [:index, :create]
  before_action :authenticate_user!, only: [:index, :create]
  before_action :are_you_seller?, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_shipping_info = OrderShippingInfo.new
  end

  def create
    @order_shipping_info = OrderShippingInfo.new(order_params)
    if @order_shipping_info.valid?
      pay_item
      @order_shipping_info.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_shipping_info).permit(:postal_code,
                                                :prefecture_id,
                                                :city,
                                                :address,
                                                :building, :phone_number).merge(user_id: current_user.id,
                                                                                item_id: @item.id,
                                                                                token: params[:token],
                                                                                price: @item.price)
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def are_you_seller?
    if @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def sold_out?
    if @item.order.present?
      redirect_to root_path
    end
  end

  def pay_item
    Payjp.api_key =  ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: order_params[:price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
