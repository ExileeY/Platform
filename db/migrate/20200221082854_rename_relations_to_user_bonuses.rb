class RenameRelationsToUserBonuses < ActiveRecord::Migration[5.2]
  def change
    rename_table :relations, :user_bonuses
  end
end
