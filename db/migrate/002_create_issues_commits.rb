class CreateIssuesCommits < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    create_join_table :issues, :commits do |t|
      t.index :issue_id
    end
  end
end
