class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer :follower, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
