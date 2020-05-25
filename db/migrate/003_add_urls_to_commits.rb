class AddUrlsToCommits < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    add_column :commits, :repo_url, :string
  end
end

