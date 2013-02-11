class FixTypeColumnName < ActiveRecord::Migration
  def change
    rename_column :events, :type, :party_type
  end
end
