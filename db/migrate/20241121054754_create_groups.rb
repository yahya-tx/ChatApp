class CreateGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :groups do |t|
      t.string :title
      t.text :description
      t.integer :user_ids, default: [], array: true
      t.string :image

      t.timestamps
    end
  end
end
