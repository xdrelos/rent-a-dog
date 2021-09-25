class CreateDogs < ActiveRecord::Migration[6.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.text :description
      t.integer :palmares
      t.string :city
      t.integer :age
      t.integer :price_per_hour
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
