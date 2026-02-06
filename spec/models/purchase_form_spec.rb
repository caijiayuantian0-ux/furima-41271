require "rails_helper"

RSpec.describe PurchaseForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    good = FactoryBot.create(:good)
     @purchase_form = FactoryBot.build(:purchase_form, :with_user_and_good)
  end

  describe "購入情報の保存" do
    context "購入できるとき" do
      it "必要な情報が全てあれば有効" do
        expect(@purchase_form).to be_valid
      end

      it "building_nameが空でも有効" do
        @purchase_form.building_name = ""
        expect(@purchase_form).to be_valid
      end
    end

    context "購入できないとき" do
      it "postal_codeが空だと無効" do
        @purchase_form.postal_code = ""
        @purchase_form.valid?
        expect(@purchase_form.errors[:postal_code]).to be_present
      end

      it "postal_codeが「3桁-4桁」でないと無効" do
        @purchase_form.postal_code = "1234567"
        @purchase_form.valid?
        expect(@purchase_form.errors[:postal_code]).to be_present
      end

      it "prefecture_idが1（---）だと無効" do
        @purchase_form.prefecture_id = 1
        @purchase_form.valid?
        expect(@purchase_form.errors[:prefecture_id]).to be_present
      end

      it "cityが空だと無効" do
        @purchase_form.city = ""
        @purchase_form.valid?
        expect(@purchase_form.errors[:city]).to be_present
      end

      it "street_addressが空だと無効" do
        @purchase_form.street_address = ""
        @purchase_form.valid?
        expect(@purchase_form.errors[:street_address]).to be_present
      end

      it "phone_numberが空だと無効" do
        @purchase_form.phone_number = ""
        @purchase_form.valid?
        expect(@purchase_form.errors[:phone_number]).to be_present
      end

      it "phone_numberが10桁未満だと無効" do
        @purchase_form.phone_number = "090123456"
        @purchase_form.valid?
        expect(@purchase_form.errors[:phone_number]).to be_present
      end

      it "phone_numberが12桁以上だと無効" do
        @purchase_form.phone_number = "090123456789"
        @purchase_form.valid?
        expect(@purchase_form.errors[:phone_number]).to be_present
      end

      it "phone_numberにハイフンがあると無効" do
        @purchase_form.phone_number = "090-1234-5678"
        @purchase_form.valid?
        expect(@purchase_form.errors[:phone_number]).to be_present
      end

      it "user_idが空だと無効" do
        @purchase_form.user_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors[:user_id]).to be_present
      end

      it "good_idが空だと無効" do
        @purchase_form.good_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors[:good_id]).to be_present
      end
    end
  end
end
