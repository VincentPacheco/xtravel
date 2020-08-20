class AddDurationToTravel < ActiveRecord::Migration[6.0]
  def change
    add_column :travels, :duration, :integer
  end
end
