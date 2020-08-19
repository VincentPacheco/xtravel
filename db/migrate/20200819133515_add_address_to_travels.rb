class AddAddressToTravels < ActiveRecord::Migration[6.0]
  def change
    add_column :travels, :address, :string
  end
end
