class AddBreedToDogs < ActiveRecord::Migration[6.0]
  def change
    add_reference :dogs, :breed, null: false, foreign_key: true
  end
end
