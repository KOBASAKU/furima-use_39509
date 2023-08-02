FactoryBot.define do
  factory :order_address do
  token { 'tok_abcdefghijk00000000000000000' }
  postal_code { '666-6666' }
  prefecture { 1 }
  city { '横浜市' }
  addresses { '青山1-1-1' }
  building { '' }
  phone_number { '08055555555' }
  association :user
  association :item
  end
end