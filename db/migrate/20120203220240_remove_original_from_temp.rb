class RemoveOriginalFromTemp < ActiveRecord::Migration
  def up
    remove_column :temps, :original
  end

  def down
    add_column :temps, :original, :string
  end
end
