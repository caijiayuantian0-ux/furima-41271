require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '必要な情報が全てあれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordが英字と数字の混合なら登録できる' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ）なら登録できる' do
        @user.last_name = '山田'
        expect(@user).to be_valid
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ）なら登録できる' do
        @user.first_name = 'たろう'
        expect(@user).to be_valid
      end

      it 'last_name_kanaが全角カタカナなら登録できる' do
        @user.last_name_kana = 'ヤマダ'
        expect(@user).to be_valid
      end

      it 'first_name_kanaが全角カタカナなら登録できる' do
        @user.first_name_kana = 'タロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors[:nickname]).to be_present
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors[:email]).to be_present
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to be_present
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testexample.com'
        @user.valid?
        expect(@user.errors[:email]).to be_present
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors[:password]).to be_present
      end

      it 'passwordが6文字未満では登録できない' do
        @user.password = 'a1b2c'
        @user.password_confirmation = 'a1b2c'
        @user.valid?
        expect(@user.errors[:password]).to be_present
      end

      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors[:password]).to be_present
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors[:password]).to be_present
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc124'
        @user.valid?
        expect(@user.errors[:password_confirmation]).to be_present
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors[:last_name]).to be_present
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors[:first_name]).to be_present
      end

      it 'last_nameが半角英字では登録できない（全角のみ）' do
        @user.last_name = 'Yamada'
        @user.valid?
        expect(@user.errors[:last_name]).to be_present
      end

      it 'first_nameが半角数字では登録できない（全角のみ）' do
        @user.first_name = '123'
        @user.valid?
        expect(@user.errors[:first_name]).to be_present
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors[:last_name_kana]).to be_present
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors[:first_name_kana]).to be_present
      end

      it 'last_name_kanaがひらがなでは登録できない（全角カタカナのみ）' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors[:last_name_kana]).to be_present
      end

      it 'first_name_kanaが英字では登録できない（全角カタカナのみ）' do
        @user.first_name_kana = 'TARO'
        @user.valid?
        expect(@user.errors[:first_name_kana]).to be_present
      end

      it 'date_of_birthが空では登録できない' do
        @user.date_of_birth = nil
        @user.valid?
        expect(@user.errors[:date_of_birth]).to be_present
      end
    end
  end
end
