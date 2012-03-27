class RemoveWidthHeightFromTemp < ActiveRecord::Migration
  def up
    remove_column :temps, :width
    remove_column :temps, :height
  end

  def down
    add_column :temps, :height, :integer
    add_column :temps, :width, :integer
  end
end
