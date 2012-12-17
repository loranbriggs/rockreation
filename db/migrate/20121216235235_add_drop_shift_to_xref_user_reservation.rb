class AddDropShiftToXrefUserReservation < ActiveRecord::Migration
  def change
    add_column :xref_user_reservations, :drop_shift, :boolean
  end
end
