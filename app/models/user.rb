# frozen_string_literal: true

class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :registerable, :validatable

  validates :name, presence: true
end
