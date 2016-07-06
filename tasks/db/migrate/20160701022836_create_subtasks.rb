class CreateSubtasks < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
      t.references :task, index: true, foreign_key: true
      t.integer :percent, null: false
      t.string :name, null: false
      t.boolean :complete, default: false
      t.timestamps null: false
    end
  end
end
