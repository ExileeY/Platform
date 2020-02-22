class CreateAddBalances < ActiveRecord::Migration[5.2]
  def change
    create_table :add_balances do |t|
      t.float :money
      t.integer :user_id

      t.timestamps
    end
  end
end
