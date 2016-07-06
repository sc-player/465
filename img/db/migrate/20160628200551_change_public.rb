class ChangePublic < ActiveRecord::Migration
  def change
    rename_column :images, :public, :private
  end
end
