class CreateNotifications < ActiveRecord::Migration[7.2]
  def change
    create_table :notifications do |t|
      t.text :message
      t.string :type
      t.string :status
      t.references :users, null: false, foreign_key: true
      t.timestamps
    end
  end
end
