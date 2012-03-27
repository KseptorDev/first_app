class AddOriginalLinkToTemp < ActiveRecord::Migration
  def change
    add_column :temps, :originallink, :string
  end
end
