class AddCoordinatesToTravels < ActiveRecord::Migration[6.0]
  def change
    add_column :travels, :latitude, :float
    add_column :travels, :longitude, :float
  end
end
