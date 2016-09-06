class CreateUsersMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :users_messages do |t|
      t.integer :status, default: 0
      t.belongs_to :user, foreign_key: true, index: true
      t.belongs_to :message, foreign_key: true, index: true
      t.belongs_to :chat, index: true, foreign_key: true

      t.timestamps
    end
  end
end
