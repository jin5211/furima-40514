class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    # @items = Item.all
  end

  def new
    # binding.pry
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:name,
                                :info,
                                :category_id,
                                :sales_status_id,
                                :shipping_fee_status_id,
                                :prefecture_id,
                                :schedule_delivery_id,
                                :price,
                                :image).merge(user_id: current_user.id)
  end
end