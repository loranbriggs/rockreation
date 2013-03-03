class ChangeDurationFieldInEvents < ActiveRecord::Migration
  def up
    change_column :events, :duration, :integer, :default => 0
  end

  def down
    change_column :events, :duration, :integer, :default => nil 
  end
end
