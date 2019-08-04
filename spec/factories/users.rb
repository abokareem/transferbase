# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Foo Bar' }
    password { 'test12345' }
    password_confirmation { 'test12345' }

    sequence(:email) { |n| "user_#{n}@example.com" }
  end
end
