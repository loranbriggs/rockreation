class AddToSeats < ActiveRecord::Migration
  def change
    add_column :seats, :user_id, :int
    add_column :seats, :event_id, :int
    add_column :shifts, :user_id, :int
    add_column :shifts, :event_id, :int
  end
end
