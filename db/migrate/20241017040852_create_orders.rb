class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :total_price
      t.text :notep
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :orders, :deleted_at
  end
end
