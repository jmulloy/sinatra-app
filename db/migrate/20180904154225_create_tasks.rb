class CreateTasks < ActiveRecord::Migration[4.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.boolean :complete
      t.integer :list_id
      t.timestamps null: false
    end
  end
end
