class AddNoteToBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :note, :string
  end
end
