class CreateBoths < ActiveRecord::Migration
  def change
    create_table :boths do |t|
      t.integer :tagID
      t.integer :linkID

      t.timestamps
    end
  end
end
