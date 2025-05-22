class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.string :coin_to_send
      t.string :coin_to_receive
      t.decimal :amount_to_send
      t.decimal :amount_to_receive

      t.timestamps
    end
  end
end
