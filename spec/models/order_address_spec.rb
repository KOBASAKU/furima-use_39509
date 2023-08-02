require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  
  before do
    item = FactoryBot.create(:item)
    user = FactoryBot.create(:user)
    current_user = FactoryBot.create(:user)
    @order_address = FactoryBot.build(:order_address, user_id: current_user.id, item_id: item.id)
    
  end

  context '内容に問題ない場合' do
    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@order_address).to be_valid
    end
    it 'buildingは空でも保存できること' do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end
  end


  context '内容に問題がある場合' do
   it 'userが紐付いていないと保存できないこと' do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end

    it "tokenが空では登録できないこと" do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end

    it 'itemが紐付いていないと保存できないこと' do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end

    it 'cityが空だと保存できないこと' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end

    it 'addressesが空だと保存できないこと' do
      @order_address.addresses = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Addresses can't be blank")
    end

    it 'prefectureを選択していないと保存できないこと' do
      @order_address.prefecture = 0
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
    end

    it 'phone_numberが空だと保存できないこと' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'phone_numberが半角のハイフンを含まない正しい形式でないと保存できないこと' do
      @order_address.phone_number = '00000-00000'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number Invalid. Please enter only digits in half-width characters.')
    end

    it 'phone_numberが全角を含まない正しい形式でないと保存できないこと' do
      @order_address.phone_number = '０0000-00000'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number Invalid. Please enter only digits in half-width characters.')
    end

    it 'phone_numberが9桁以下では保存できないこと' do
      @order_address.phone_number = '00000'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number Invalid. Please enter only digits in half-width characters.')
    end

    it 'postal_codeが空だと保存できないこと' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end

    it 'phone_numberが12桁以上では保存できないこと' do
      @order_address.phone_number = '000000-00000000'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number Invalid. Please enter only digits in half-width characters.')
    end

    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end

    
  end

end
