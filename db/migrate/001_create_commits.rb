class CreateCommits < Rails.version < '5.1' ? ActiveRecord::Migration : ActiveRecord::Migration[4.2]
  def change
    create_table :commits do |t|
      t.string :provider
      t.string :repo_name
      t.string :branch
      t.string :title
      t.string :url
      t.string :author_name
      t.string :display_id
    end
  end
end
