class AddWidthHeightToTemp < ActiveRecord::Migration
  def change
    add_column :temps, :width, :string
    add_column :temps, :height, :string
  end
end
