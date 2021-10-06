class AddTotalPriceToRentings < ActiveRecord::Migration[6.0]
  def change
    add_column :rentings, :total_price, :integer
  end
end
