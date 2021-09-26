class AddStatusToRentings < ActiveRecord::Migration[6.0]
  def change
    add_column :rentings, :status, :string
  end
end
