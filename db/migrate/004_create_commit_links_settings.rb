class CreateCommitLinksSettings < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    create_table :commit_links_settings do |t|
      t.integer :project_id
      t.string :repo_base_url
    end

    add_index :commit_links_settings, :project_id, :unique => true
  end
end


