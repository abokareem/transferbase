# frozen_string_literal: true

class Transfer < ApplicationRecord
  FAILURE = 1
  SUCCESS = 2

  STATUSES = [
    [FAILURE, 'Cancelled'],
    [SUCCESS, 'Completed']
  ].freeze

  belongs_to :sender, class_name: 'User', optional: true
  belongs_to :receiver, class_name: 'User'

  validates :amount, presence: true
  validates :source_currency, presence: true
  validates :target_currency, presence: true
  validates :exchange_rate, presence: true
  validates :status, inclusion: { in: STATUSES.to_h.keys }

  scope :completed, ->{ where(status: SUCCESS) }

  class << self
    def current_balance(user)
      result = { 'USD' => 0, 'EUR' => 0, 'GBP' => 0 }
      user.transfers.completed.group_by(&:target_currency).each do |currency, data|
        data.each do |transfer|
          if transfer.receiver == user
            result[currency] += transfer.amount
          else
            result[currency] -= transfer.amount
          end
        end
        result.values.map(&:to_f)
      end

      result
    end
  end
end
