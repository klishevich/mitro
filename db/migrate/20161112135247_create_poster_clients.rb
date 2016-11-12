class CreatePosterClients < ActiveRecord::Migration[5.0]
  def change
    create_table :poster_clients do |t|
      t.references :user, foreign_key: true
      t.boolean :is_active, default: false
      t.integer :poster_client_id
      t.integer :client_sex, default: 0
      t.string :phone
      t.string :card_number
      t.integer :client_groups_id_client
      t.string :country
      t.string :city
      t.date :birthday

      t.timestamps
    end
  end
end
