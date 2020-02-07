class AddThemesTagsToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :theme, :string
    add_column :projects, :tag, :text
  end
end
