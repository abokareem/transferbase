# frozen_string_literal: true

class TransfersController < ApplicationController
  def new
    @transfer = current_user.outgoing_transfers.new
  end

  def create
    @transfer = current_user.outgoing_transfers.new(transfer_params)
    transaction_service.finalize_transaction

    # If we have any error while fetching the exchange rates, render those errors before
    # saving the transaction
    if @transfer.errors.any?
      render :new
    elsif @transfer.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def transfer_params
    params.require(:transfer).permit(:amount, :exchange_rate, :receiver_id, :sender_id, :source_currency, :target_currency)
  end

  def transaction_service
    @transaction_service ||= TransactionService.new(@transfer)
  end
end
