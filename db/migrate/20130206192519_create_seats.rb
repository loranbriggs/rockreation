class CreateSeats < ActiveRecord::Migration
  def change
    create_table :seats do |t|
      t.boolean :drop

      t.timestamps
    end
  end
end
