# frozen_string_literal: true

if User.count.zero? && !Rails.env.production?
  User.transaction do
    user1 = User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'test12345', password_confirmation: 'test12345')
    user2 = User.create(name: 'Jane Doe', email: 'jane.doe@example.com', password: 'test12345', password_confirmation: 'test12345')

    user1.confirm
    user2.confirm

    [user1, user2].each do |receiver|
      Transfer.create(
        receiver: receiver,
        amount: 1_000.0,
        source_currency: 'USD',
        target_currency: 'USD',
        exchange_rate: 1.0,
        status: Transfer::SUCCESS
      )
    end
  end
end
