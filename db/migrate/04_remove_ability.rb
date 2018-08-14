class RemoveAbility < ActiveRecord::Migration
  def change
    remove_column :characters, :ability
  end
end
