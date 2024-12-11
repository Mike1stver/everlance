class CreateTasks < ActiveRecord::Migration[5.0]
  def up
    create_table :tasks do |t|
      t.string :title, null: false
      t.boolean :completed, default: false
      t.text :notes
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :tasks, :title
  end

  def down
    drop_table :tasks
    remove_index :tasks, :title
  end
end
