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

    update_transfer_exchange_rate(rates)
    update_status
  end

  private

  attr_reader :transfer
  delegate :amount, :target_currency, to: :transfer

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
                             when 'EUR' then rates[:eur].truncate(3)
                             when 'GBP' then rates[:gbp].truncate(3)
                             else
                               1.0
                             end
  end

  def update_status
    transfer.status = if transaction_possible?
                        Transfer::SUCCESS
                      else
                        Transfer::FAILURE
                      end
  end

  # Just checks what is the current balance's target currency value. Normally, there may be a combination
  # of different currencies with exchange rates.
  # EX: A user's current balance is { 'USD' => 100, 'EUR' => 50, 'GBP' => 0 }
  # If this user wants to send 150 dollars, then this could be possible because 50 EUR is almost ~55.6 USD
  # where user can then have this transaction. For now, the method only compares target_currency value.
  def transaction_possible?
    current_balance = Transfer.current_balance(transfer.sender)
    current_balance[target_currency] > amount
  end
end
