class AddDateColumnToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :end_date, :string
  end
end
