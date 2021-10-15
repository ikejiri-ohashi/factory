class CreateCompanyProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :company_profiles do |t|
      t.integer :category_id
      t.integer :sub_category_id
      t.text :content
      t.string :self_introduction
      t.integer :place_id
      t.string :company_url
      t.string :contact
      t.references :user,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
