class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :password_digetst, :password_digest
  end
end
