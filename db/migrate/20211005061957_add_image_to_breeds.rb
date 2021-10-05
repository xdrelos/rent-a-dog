class AddImageToBreeds < ActiveRecord::Migration[6.0]
  def change
    add_column :breeds, :image, :string
  end
end
