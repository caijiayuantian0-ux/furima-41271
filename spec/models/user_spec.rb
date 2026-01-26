require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'validations' do
    context 'presence' do
      it 'nicknameが必須' do
        user.nickname = ''
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'last_nameが必須' do
        user.last_name = ''
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'first_nameが必須' do
        user.first_name = ''
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("First name can't be blank")
      end

      it 'last_name_kanaが必須' do
        user.last_name_kana = ''
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'first_name_kanaが必須' do
        user.first_name_kana = ''
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'date_of_birthが必須' do
        user.date_of_birth = nil
        expect(user).to be_invalid
        expect(user.errors.full_messages).to include("Date of birth can't be blank")
      end
    end

    context 'kana format（全角カタカナ）' do
      it 'last_name_kana：カタカナならOK' do
        user.last_name_kana = 'ヤマダ'
        expect(user).to be_valid
      end

      it 'last_name_kana：ひらがなはNG' do
        user.last_name_kana = 'やまだ'
        expect(user).to be_invalid
        # messageは環境で変わるので include? だけでもOK
        expect(user.errors[:last_name_kana]).to be_present
      end

      it 'first_name_kana：カタカナならOK' do
        user.first_name_kana = 'タロウ'
        expect(user).to be_valid
      end

      it 'first_name_kana：英字はNG' do
        user.first_name_kana = 'TARO'
        expect(user).to be_invalid
        expect(user.errors[:first_name_kana]).to be_present
      end
    end

    context 'password format（英字+数字、英数字のみ）' do
      it '英字+数字の混合ならOK' do
        user.password = 'abc123'
        user.password_confirmation = 'abc123'
        expect(user).to be_valid
      end

      it '数字のみはNG' do
        user.password = '123456'
        user.password_confirmation = '123456'
        expect(user).to be_invalid
        expect(user.errors[:password]).to be_present
      end

      it '英字のみはNG' do
        user.password = 'abcdef'
        user.password_confirmation = 'abcdef'
        expect(user).to be_invalid
        expect(user.errors[:password]).to be_present
      end

      it '記号を含むとNG（英数字のみ想定）' do
        user.password = 'abc12!'
        user.password_confirmation = 'abc12!'
        expect(user).to be_invalid
        expect(user.errors[:password]).to be_present
      end

      it 'allow_nil: true（更新時にpassword未変更でもOK想定）' do
        u = create(:user)
        expect(u.update(nickname: '変更')).to be true
      end
    end
  end
end
