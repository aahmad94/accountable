class ChangeColVerified < ActiveRecord::Migration[5.1]
  def change
    change_column :challenges, :verified, :boolean, :default => false
  end
end
