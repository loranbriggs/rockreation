class AddDetailToEvents < ActiveRecord::Migration
  def change
    add_column :events, :detail, :string
  end
end
