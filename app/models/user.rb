# frozen_string_literal: true

class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :registerable, :validatable

  has_many :outgoing_transfers, class_name: 'Transfer', foreign_key: 'sender_id', dependent: :destroy
  has_many :incoming_transfers, class_name: 'Transfer', foreign_key: 'receiver_id', dependent: :destroy

  validates :name, presence: true
end
