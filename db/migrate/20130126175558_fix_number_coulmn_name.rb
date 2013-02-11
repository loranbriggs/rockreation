class FixNumberCoulmnName < ActiveRecord::Migration
  def change
    rename_column :users, :number, :phone
  end
end
