class AddDateToBooking < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :date, :date
  end
end
