class OrdersController < ApplicationController
  before_action :set_item
  before_action :sold_out?, only: [:index, :create]
  before_action :authenticate_user!, only: [:index, :create]
  before_action :are_you_seller?, only: [:index, :create]

  def index
    @order_shipping_info = OrderShippingInfo.new
  end

  def create
    @order_shipping_info = OrderShippingInfo.new(order_params)
    if @order_shipping_info.valid?
      @order_shipping_info.save
      redirect_to root_path
    else
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
                                                                                item_id: @item.id)
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
end
