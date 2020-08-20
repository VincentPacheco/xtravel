class AddLongdescriptionToTravels < ActiveRecord::Migration[6.0]
  def change
    add_column :travels, :longdescription, :text
  end
end
