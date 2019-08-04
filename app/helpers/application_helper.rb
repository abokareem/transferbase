# frozen_string_literal: true

module ApplicationHelper
  def display_amount(amount, receiver, user)
    if receiver == user
      "<span class='green'>+#{amount}</span>".html_safe
    else
      "<span class='red'>-#{amount}</span>".html_safe
    end
  end

  def transaction_status(status)
    Transfer::STATUSES.to_h[status]
  end

  def formatted_date(date)
    date.strftime('%B %-d, %Y %H:%M')
  end
end
