class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :author_id, index: true, foreign_key: true
      t.belongs_to :chat, index: true, foreign_key: true

      t.timestamps
    end
  end
end
