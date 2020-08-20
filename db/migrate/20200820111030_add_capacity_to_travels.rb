class AddCapacityToTravels < ActiveRecord::Migration[6.0]
  def change
    add_column :travels, :capacity, :integer
  end
end
