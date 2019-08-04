# frozen_string_literal: true

class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.references :sender, foreign_key: { to_table: 'users' }
      t.references :receiver, foreign_key: { to_table: 'users' }
      t.decimal :amount, null: false
      t.string :source_currency, null: false
      t.string :target_currency, null: false
      t.decimal :exchange_rate, null: false
      t.integer :status, null: false

      t.timestamps
    end
  end
end
