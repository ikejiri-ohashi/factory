class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :name,            null: false
      t.integer :place_id,           null: false
      t.integer :deadline_id,        null: false
      t.integer :category_id,       null: false
      t.integer :sub_category_id,       null: false
      t.string :job_image
      t.string :memo
      t.string :contact,         null: false
      t.references :user,        null: false, foreign_key: true
      t.timestamps
    end
  end
end
