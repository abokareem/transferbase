# frozen_string_literal: true

require 'rest-client'

# A service handles some transaction functionalities
class TransactionService
  def initialize(transfer)
    @transfer = transfer
  end

  def finalize_transaction
    rates = fetch_exchange_rates

    return if transfer.errors.any?

    update_status
    update_transfer_exchange_rate(rates)
  end

  private

  attr_reader :transfer
  delegate :target_currency, to: :transfer

  # Application assumes all users have default currency USD.
  # Therefore the exchange rate request is done based on USD for the EUR and GBP currencies.
  # Example Response:
  # {
  #   "rates": {
  #     "EUR": 0.9004141905,
  #     "GBP": 0.823924005
  #   },
  #   "base": "USD",
  #   "date": "2019-08-02"
  # }
  def fetch_exchange_rates
    response = RestClient.get('https://api.exchangeratesapi.io/latest?base=USD&symbols=EUR,GBP')
    parsed_response = JSON.parse(response.body)
    { eur: parsed_response['rates']['EUR'], gbp: parsed_response['rates']['GBP'] }
  rescue RestClient::ExceptionWithResponse => _e
    transfer.errors.add(:base, 'An error occurred while fetching exchange rates. Please try again later!')
  end

  def update_transfer_exchange_rate(rates)
    transfer.exchange_rate = case target_currency
                             when 'EUR' then rates[:eur]
                             when 'GBP' then rates[:gbp]
                             else
                               1.0
                             end
  end

  def update_status
    # TODO: Until balance calculations are implemented, set all transactions to successful (completed)
    transfer.status = Transfer::SUCCESS
  end
end
