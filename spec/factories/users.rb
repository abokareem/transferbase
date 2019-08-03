# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'Foo Bar' }
    email { 'foo.bar@example.com' }
    password { 'test12345' }
    password_confirmation { 'test12345' }
  end
end
