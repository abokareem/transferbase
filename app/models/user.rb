# frozen_string_literal: true

class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :registerable, :validatable

  has_many :outgoing_transfers, class_name: 'Transfer', foreign_key: 'sender_id', dependent: :destroy
  has_many :incoming_transfers, class_name: 'Transfer', foreign_key: 'receiver_id', dependent: :destroy

  validates :name, presence: true

  # A method to get all user related transfers (whether it is sent or received)
  def transfers
    Transfer.where('sender_id = ? OR receiver_id = ?', id, id)
  end

  protected

  # Overwrite devise's `after_confirmation` method to generate the initial +1000 USD
  # right after a user is confirmed.
  def after_confirmation
    Transfer.create(
      receiver: self,
      amount: 1_000.0,
      source_currency: 'USD',
      target_currency: 'USD',
      exchange_rate: 1.0,
      status: Transfer::SUCCESS
    )
    super
  end
end
