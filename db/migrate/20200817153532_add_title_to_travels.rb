class AddTitleToTravels < ActiveRecord::Migration[6.0]
  def change
    add_column :travels, :title, :string
  end
end
