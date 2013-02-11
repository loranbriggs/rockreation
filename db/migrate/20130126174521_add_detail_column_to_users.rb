class AddDetailColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :detail, :string
  end
end
