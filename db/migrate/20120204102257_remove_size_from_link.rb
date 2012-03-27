class RemoveSizeFromLink < ActiveRecord::Migration
  def up
    remove_column :links, :size
  end

  def down
    add_column :links, :size, :integer
  end
end
