require 'rails_helper'

RSpec.describe OrderShippingInfo, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user_id: user.id)
    @order_shipping_info = FactoryBot.build(:order_shipping_info, user_id: user.id, item_id: item.id)
  end

  describe '商品購入情報の保存' do

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_shipping_info).to be_valid
      end
      it '建物名は空でも保存できること' do
        @order_shipping_info.building = ''
        @order_shipping_info.valid?
        expect(@order_shipping_info).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @order_shipping_info.postal_code = ''
        @order_shipping_info.valid?
        expect(@order_shipping_info.errors.full_messages).to include("Postal code can't be blank")
      end
      # 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと'
      it 'postal_codeが全角のとき保存できないこと' do
        @order_shipping_info.postal_code = '１２３−４５６７'
        @order_shipping_info.valid?
        expect(@order_shipping_info.errors.full_messages).to include('Postal code is invalid')
      end
      it 'postal_codeがハイフンを含んでないと保存できないこと' do
        @order_shipping_info.postal_code = Faker::Number.number(digits: 7)
        @order_shipping_info.valid?
        expect(@order_shipping_info.errors.full_messages).to include('Postal code is invalid')
      end
      it '都道府県を選択していないと保存できないこと' do
        @order_shipping_info.prefecture_id = 1
        @order_shipping_info.valid?
        expect(@order_shipping_info.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @order_shipping_info.city = ''
        @order_shipping_info.valid?
        expect(@order_shipping_info.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @order_shipping_info.address = ''
        @order_shipping_info.valid?
        expect(@order_shipping_info.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @order_shipping_info.phone_number = ''
        @order_shipping_info.valid?
        expect(@order_shipping_info.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が９桁以下だと保存できないこと' do
        @order_shipping_info.phone_number = '123456789'
        @order_shipping_info.valid?
        expect(@order_shipping_info.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上だと保存できないこと' do
        @order_shipping_info.phone_number = '123456789012'
        @order_shipping_info.valid?
        expect(@order_shipping_info.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
