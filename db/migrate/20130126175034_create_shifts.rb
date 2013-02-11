class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.boolean :drop

      t.timestamps
    end
  end
end
