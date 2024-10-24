class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :carts, :deleted_at
  end
end
