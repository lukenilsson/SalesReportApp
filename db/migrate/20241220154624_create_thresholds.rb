class CreateThresholds < ActiveRecord::Migration[8.0]
  def change
    create_table :thresholds do |t|
      t.references :account, null: false, foreign_key: true
      t.integer :quantity_threshold

      t.timestamps
    end
  end
end
