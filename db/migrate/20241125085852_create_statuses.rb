class CreateStatuses < ActiveRecord::Migration[7.1]
  def change
    create_table :statuses do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.string :status_type
      t.references :conversation_window, null: false, foreign_key: true

      t.timestamps
    end
  end
end
