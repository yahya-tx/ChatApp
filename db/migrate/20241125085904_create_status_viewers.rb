class CreateStatusViewers < ActiveRecord::Migration[7.1]
  def change
    create_table :status_viewers do |t|
      t.references :status, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :viewed_at

      t.timestamps
    end
  end
end
