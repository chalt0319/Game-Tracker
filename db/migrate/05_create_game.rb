class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.integer :user_id
    end
  end
end