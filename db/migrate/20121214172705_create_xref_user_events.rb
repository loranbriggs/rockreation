class CreateXrefUserEvents < ActiveRecord::Migration
  def change
    create_table :xref_user_events do |t|
      t.integer :event_id
      t.integer :user_id
      t.boolean :host

      t.timestamps
    end
  end
end
