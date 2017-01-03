class AddCardPayToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :is_card_pay, :boolean, default: false
    add_column :orders, :total_sum, :decimal
  end
end
