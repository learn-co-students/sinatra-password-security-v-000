class AddBalanceColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :balance, :decimal, default: 0.00
  end
end
