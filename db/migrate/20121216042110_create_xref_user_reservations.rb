class CreateXrefUserReservations < ActiveRecord::Migration
  def change
    create_table :xref_user_reservations do |t|
      t.integer :reservation_id
      t.integer :user_id
      t.boolean :host

      t.timestamps
    end
  end
end
