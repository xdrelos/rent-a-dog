class CreateRentings < ActiveRecord::Migration[6.0]
  def change
    create_table :rentings do |t|
      t.date :date
      t.integer :number_of_hours
      t.references :user, null: false, foreign_key: true
      t.references :dog, null: false, foreign_key: true

      t.timestamps
    end
  end
end
