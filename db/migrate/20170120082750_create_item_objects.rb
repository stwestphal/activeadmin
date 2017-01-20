class CreateItemObjects < ActiveRecord::Migration[5.0]
  def change
    create_table :item_objects do |t|
      t.references :book, foreign_key: true
      t.integer :position
      t.references :item_type, foreign_key: true
      t.integer :netto_price
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end
end
