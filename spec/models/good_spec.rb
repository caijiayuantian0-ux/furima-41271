require 'rails_helper'

RSpec.describe Good, type: :model do
  before do
    @good = FactoryBot.build(:good)
  end

  describe '商品出品' do
    context '出品できるとき' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@good).to be_valid
      end
    end

    context '出品できないとき' do
      it '画像が空だと保存できない' do
        @good.image = nil
        @good.valid?
        expect(@good.errors.full_messages).to include("Image can't be blank").or include("Image を選択してください")
      end

      it '商品名が空だと保存できない' do
        @good.name = ''
        @good.valid?
        expect(@good.errors.full_messages).to include("Name can't be blank")
      end

      it '商品名が41文字以上だと保存できない' do
        @good.name = 'a' * 41
        @good.valid?
        expect(@good.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
      end

      it '商品説明が空だと保存できない' do
        @good.description = ''
        @good.valid?
        expect(@good.errors.full_messages).to include("Description can't be blank")
      end

      it '商品説明が1001文字以上だと保存できない' do
        @good.description = 'a' * 1001
        @good.valid?
        expect(@good.errors.full_messages).to include("Description is too long (maximum is 1000 characters)")
      end

      it 'カテゴリーが---(1)だと保存できない' do
        @good.category_id = 1
        @good.valid?
        expect(@good.errors.full_messages.join).to match(/Category.*(blank|選択)/)
      end

      it '商品の状態が---(1)だと保存できない' do
        @good.condition_id = 1
        @good.valid?
        expect(@good.errors.full_messages.join).to match(/Condition.*(blank|選択)/)
      end

      it '配送料の負担が---(1)だと保存できない' do
        @good.shipping_fee_id = 1
        @good.valid?
        expect(@good.errors.full_messages.join).to match(/Shipping fee.*(blank|選択)/i)
      end

      it '発送元の地域が---(1)だと保存できない' do
        @good.prefecture_id = 1
        @good.valid?
        expect(@good.errors.full_messages.join).to match(/Prefecture.*(blank|選択)/)
      end

      it '発送までの日数が---(1)だと保存できない' do
        @good.days_to_ship_id = 1
        @good.valid?
        expect(@good.errors.full_messages.join).to match(/Days to ship.*(blank|選択)/i)
      end

      it '価格が空だと保存できない' do
        @good.price = nil
        @good.valid?
        expect(@good.errors.full_messages).to include("Price can't be blank")
      end

      it '価格が全角数字だと保存できない（半角のみ）' do
        @good.price = '１０００'
        @good.valid?
        # format の message を入れてるならこれ
        expect(@good.errors.full_messages.join).to match(/Price.*(半角|is not a number)/)
      end

      it '価格が英字だと保存できない' do
        @good.price = 'abc'
        @good.valid?
        expect(@good.errors.full_messages.join).to match(/Price.*(is not a number|半角)/)
      end

      it '価格が299以下だと保存できない' do
        @good.price = 299
        @good.valid?
        expect(@good.errors.full_messages.join).to match(/Price.*(greater than or equal to 300)/)
      end

      it '価格が10000000以上だと保存できない' do
        @good.price = 10_000_000
        @good.valid?
        expect(@good.errors.full_messages.join).to match(/Price.*(less than or equal to 9999999)/)
      end

      it 'userが紐付いていないと出品できない' do
        @good.user = nil
        @good.valid?
        expect(@good.errors[:user]).to be_present
      end
    end
  end
end
