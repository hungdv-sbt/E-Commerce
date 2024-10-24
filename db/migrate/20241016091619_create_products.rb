class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.bigint :price
      t.string :image
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :products, :deleted_at
  end
end
