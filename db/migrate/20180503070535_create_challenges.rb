class CreateChallenges < ActiveRecord::Migration[5.1]
  def change
    create_table :challenges do |t|
      t.integer :group_subscription_id, null: false
      t.text :body, null: false 
      t.boolean :completed, null: false

      t.timestamps
    end
  end
end
