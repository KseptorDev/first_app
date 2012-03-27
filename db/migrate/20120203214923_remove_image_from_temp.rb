class RemoveImageFromTemp < ActiveRecord::Migration
  def up
    remove_column :temps, :image
  end

  def down
    add_column :temps, :image, :integer
  end
end
