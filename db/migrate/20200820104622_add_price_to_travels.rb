class AddPriceToTravels < ActiveRecord::Migration[6.0]
  def change
    add_column :travels, :price, :integer
  end
end
