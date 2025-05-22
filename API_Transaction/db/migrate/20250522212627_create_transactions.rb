class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :coin_to_send
      t.string :coin_to_receive
      t.decimal :amount_to_send
      t.decimal :amount_to_receive
      t.references :sender, null: false
      t.references :receiver, null: false

      t.timestamps
    end

    add_foreign_key :transactions, :users, column: :sender_id
    add_foreign_key :transactions, :users, column: :receiver_id
  end
end
