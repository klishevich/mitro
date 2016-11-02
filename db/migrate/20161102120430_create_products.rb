class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.string :volume
      t.boolean :is_delivery
      t.boolean :is_sibirskaya
      t.boolean :is_volochaevskaya
      t.boolean :is_foodtrack

      t.timestamps
    end
  end
end
