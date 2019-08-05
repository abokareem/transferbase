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

  def display_current_balance(balance)
    content_tag :div, class: 'panel panel-info' do
      content_tag :div, class: 'panel-body' do
        "Current Balance: #{balance['USD']} USD, #{balance['EUR']} EUR, #{balance['GBP']} GBP"
      end
    end
  end
end
