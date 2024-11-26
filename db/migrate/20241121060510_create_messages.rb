class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.text :content
      t.integer :group_id
      t.string :attachment
      t.boolean :read

      t.timestamps
    end
  end
end
