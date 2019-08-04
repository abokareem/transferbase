# frozen_string_literal: true

module ApplicationHelper
  def display_amount(amount, receiver, user)
    if receiver == user
      "<span class='green'>+#{amount}</span>".html_safe
    else
      "<span class='red'>-#{amount}</span>".html_safe
    end
  end
end
