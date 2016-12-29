class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :person_name
      t.string :phone
      t.string :email
      t.text :comment
      t.references :order_status, foreign_key: true

      t.timestamps
    end
  end
end
