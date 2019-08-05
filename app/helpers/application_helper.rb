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
        "<b>Current Balance</b>: #{balance['USD']} USD, #{balance['EUR']} EUR, #{balance['GBP']} GBP".html_safe
      end
    end
  end

  def display_status(status)
    if status == 'Cancelled'
      "<span class='red'>#{status}</span>".html_safe
    else
      status
    end
  end
end
