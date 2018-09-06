class CreateLists < ActiveRecord::Migration[4.2]
  def change
    create_table :lists do |t|
      t.string :name
      t.string :content
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
