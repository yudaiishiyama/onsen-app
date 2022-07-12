class CreateNotices < ActiveRecord::Migration[6.0]
  def change
    create_table :notices do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.references :post, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
  end
end
