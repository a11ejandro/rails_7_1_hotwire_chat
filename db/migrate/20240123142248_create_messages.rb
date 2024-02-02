class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.text :content, null: false
      t.timestamps
    end
  end
end
