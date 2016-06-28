class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :str
      t.integer :image_id

      t.timestamps null: false
    end
  end
end
