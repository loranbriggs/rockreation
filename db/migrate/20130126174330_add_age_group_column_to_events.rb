class AddAgeGroupColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :ageGroup, :string
  end
end
