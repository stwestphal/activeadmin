class CreateItemTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :item_types do |t|
      t.string :name
      t.string :description
      t.integer :accounting_number
      t.integer :active_flag

      t.timestamps
    end
  end
end
