class CreateRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :relations do |t|
      t.integer :user_id
      t.integer :bonus_id

      t.timestamps
    end
  end
end
