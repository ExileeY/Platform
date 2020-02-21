class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.float :money
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end
  end
end
