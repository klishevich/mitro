class AddBonusInfoToPosterClients < ActiveRecord::Migration[5.0]
  def change
    add_column :poster_clients, :has_bonus, :boolean, default: false
    add_column :poster_clients, :bonus_text, :text
    add_column :poster_clients, :bonus_updated_at, :datetime, default: '2000-01-01'
  end
end
