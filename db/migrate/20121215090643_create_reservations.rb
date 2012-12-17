class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :name, :length => 50
      t.datetime :date
      t.integer :participants

      t.timestamps
    end
  end
end
