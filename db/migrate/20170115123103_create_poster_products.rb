class CreatePosterProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :poster_products do |t|
      t.integer :product_id, index: true
      t.string :product_name

      t.timestamps
    end
  end
end
