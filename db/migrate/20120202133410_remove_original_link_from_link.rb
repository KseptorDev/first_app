class RemoveOriginalLinkFromLink < ActiveRecord::Migration
  def up
    remove_column :links, :originallink
  end

  def down
    add_column :links, :originallink, :string
  end
end
