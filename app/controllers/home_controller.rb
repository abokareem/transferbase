# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @transfers = current_user.transfers
    @current_balance = Transfer.current_balance(current_user)
  end
end
