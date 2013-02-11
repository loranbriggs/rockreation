class AddStreet2ColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :street2, :string
  end
end
