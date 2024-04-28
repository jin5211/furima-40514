require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nickname、email、password、password_confirmation、
          last_name、first_name、last_name_kana、first_name_kana、
          birth_date が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank"
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank"
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank"
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank"
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Birth date can't be blank"
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include 'Email has already been taken'
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it 'passwordが英数字混合ではないと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '12345abc'
        @user.password_confirmation = '123456abc'
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Password is invalid'
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = Gimei.name.last.romaji
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name is invalid'
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = Gimei.name.first.romaji
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name is invalid'
      end
      it 'last_name_kanaが全角（カタカナ）でないと登録できない' do
        @user.last_name_kana = Gimei.name.last.kanji
        @user.valid?
        expect(@user.errors.full_messages).to include 'Last name kana is invalid'
      end
      it 'first_name_kanaが全角（カタカナ）でないと登録できない' do
        @user.first_name_kana = Gimei.name.first.kanji
        @user.valid?
        expect(@user.errors.full_messages).to include 'First name kana is invalid'
      end
    end
  end
end
