class AddMoneyColumnsToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :money_donated, :float
    add_column :projects, :money_need, :float
  end
end
