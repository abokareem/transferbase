# frozen_string_literal: true

if User.count.zero? && !Rails.env.production?
  User.transaction do
    user1 = User.create(name: 'John Doe', email: 'john.doe@example.com', password: 'test12345', password_confirmation: 'test12345')
    user2 = User.create(name: 'Jane Doe', email: 'jane.doe@example.com', password: 'test12345', password_confirmation: 'test12345')

    user1.confirm
    user2.confirm
  end
end
