class ChangeColumnsChallenges < ActiveRecord::Migration[5.1]
  def change
    rename_column :challenges, :completed, :verified
    rename_column :challenges, :body, :description
    add_column :challenges, :name, :string
    add_column :challenges, :expiration, :datetime
  end
end
