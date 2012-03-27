class RemoveOriginalLinkFromTemp < ActiveRecord::Migration
  def up
    remove_column :temps, :originallink
  end

  def down
    add_column :temps, :originallink, :string
  end
end
