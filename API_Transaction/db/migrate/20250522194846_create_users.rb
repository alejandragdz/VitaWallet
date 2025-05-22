class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.decimal :btc_wallet
      t.decimal :usd_wallet

      t.timestamps
    end
  end
end
