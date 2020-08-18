class AddDescriptionToTravel < ActiveRecord::Migration[6.0]
  def change
    add_column :travels, :description, :string
  end
end
