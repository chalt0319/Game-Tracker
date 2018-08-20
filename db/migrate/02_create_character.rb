class CreateCharacter < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name
      t.string :ability
      t.integer :game_id
    end
  end
end
