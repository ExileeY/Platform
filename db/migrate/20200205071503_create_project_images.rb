class CreateProjectImages < ActiveRecord::Migration[5.2]
  def change
    create_table :project_images do |t|
      t.references :project
      t.string :image

      t.timestamps
    end
  end
end
