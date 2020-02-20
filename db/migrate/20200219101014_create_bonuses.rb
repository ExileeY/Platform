class CreateBonuses < ActiveRecord::Migration[5.2]
  def change
    create_table :bonuses do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :project_id

      t.timestamps
    end
  end
end
