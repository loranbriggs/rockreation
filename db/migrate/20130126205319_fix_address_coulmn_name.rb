class FixAddressCoulmnName < ActiveRecord::Migration
  def change
    rename_column :users, :address, :street1
  end
end
