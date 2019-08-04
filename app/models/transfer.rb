# frozen_string_literal: true

class Transfer < ApplicationRecord
  FAILURE = 1
  SUCCESS = 2

  STATUSES = [
    [FAILURE, 'Failure'],
    [SUCCESS, 'Success']
  ].freeze

  belongs_to :sender, class_name: 'User', optional: true
  belongs_to :receiver, class_name: 'User'

  validates :amount, presence: true
  validates :source_currency, presence: true
  validates :target_currency, presence: true
  validates :exchange_rate, presence: true
  validates :status, inclusion: { in: STATUSES.to_h.keys }
end
