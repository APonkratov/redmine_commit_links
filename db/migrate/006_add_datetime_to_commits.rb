class AddDatetimeToCommits < ActiveRecord::Migration[5.2]
  def up
    add_column :commits, :commit_date, :timestamp, null: false
    add_index :commits, :commit_date
  end

  def down
    remove_column :commits, :commit_date
  end
end


