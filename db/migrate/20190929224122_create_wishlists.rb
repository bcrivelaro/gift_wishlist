class CreateWishlists < ActiveRecord::Migration[5.2]
  def change
    create_table :wishlists do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.string :token, null: false

      t.timestamps
    end

    add_index :wishlists, :token, unique: true
  end
end
