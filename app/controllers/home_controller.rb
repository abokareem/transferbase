# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @transfers = current_user.transfers
  end
end
