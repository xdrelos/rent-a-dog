class DeleteBreedToDogs < ActiveRecord::Migration[6.0]
  def change
    remove_column :dogs, :breed
  end
end
