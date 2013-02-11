class FixTypeColumnNameAgain < ActiveRecord::Migration
  def change
    rename_column :events, :party_type, :event_type
  end
end
