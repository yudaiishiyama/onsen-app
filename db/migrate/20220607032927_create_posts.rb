class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :address,null: false
      t.string :spring_quality,null: false
      t.text :description,null: false
      t.timestamps
    end
  end
end
