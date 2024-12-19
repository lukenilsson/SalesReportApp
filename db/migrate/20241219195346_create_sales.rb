class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.references :account, null: false, foreign_key: true
      t.string :upc
      t.string :item
      t.integer :quantity
      t.integer :month
      t.integer :year
      t.date :sale_date

      t.timestamps
    end
  end
end
