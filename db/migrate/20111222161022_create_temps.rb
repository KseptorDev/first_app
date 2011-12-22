class CreateTemps < ActiveRecord::Migration
  def change
    create_table :temps do |t|
      t.string :link
      t.string :tags
      t.string :image_name

      t.timestamps
    end
  end
end
