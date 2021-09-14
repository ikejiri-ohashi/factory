class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :name,            null: false
      t.string :place,           null: false
      t.string :deadline,        null: false
      t.integer :category,       null: false
      t.string :memo,            null: false
      t.string :contact,         null: false
      t.references :user,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
