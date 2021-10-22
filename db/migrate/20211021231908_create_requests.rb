class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.references :user, foreign_key: true
      t.references :request, foreign_key: { to_table: :users }
      t.references :job, null: false, foreign_key: true
      t.timestamps
    end
  end
end
