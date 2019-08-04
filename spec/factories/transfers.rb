# frozen_string_literal: true

FactoryBot.define do
  factory :transfer do
    amount { '100.00' }
    source_currency { 'USD' }
    target_currency { 'EUR' }
    exchange_rate { '0.98' }
    status { 1 }

    association :sender, factory: :user
    association :receiver, factory: :user
  end
end
