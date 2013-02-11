class AddMembershipColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :membership, :integer
  end
end
