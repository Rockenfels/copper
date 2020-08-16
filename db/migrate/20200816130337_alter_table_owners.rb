class AlterTableOwners < ActiveRecord::Migration[5.2]
  def change
    change_table :owners do |t|
      rename_column :owners, :password, :password_digest
    end
  end
end
