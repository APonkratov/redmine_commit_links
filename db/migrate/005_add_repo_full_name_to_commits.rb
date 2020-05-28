class AddRepoFullNameToCommits < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    add_column :commits, :repo_full_name, :string
  end
end


