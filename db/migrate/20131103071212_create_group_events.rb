class CreateGroupEvents < ActiveRecord::Migration
  def change
    create_table :group_events do |t|

      t.timestamps
    end
  end
end
