class AddIsMainToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :is_main, :boolean
  end
end
