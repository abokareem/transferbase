# frozen_string_literal: true

class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :registerable, :validatable

  has_many :outgoing_transfers, class_name: 'Transfer', foreign_key: 'sender_id', dependent: :destroy
  has_many :incoming_transfers, class_name: 'Transfer', foreign_key: 'receiver_id', dependent: :destroy

  validates :name, presence: true

  def transfers
    Transfer.where('sender_id = ? OR receiver_id = ?', id, id)
  end

  protected

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
