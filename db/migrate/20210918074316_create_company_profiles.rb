class CreateCompanyProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :company_profiles do |t|
      t.string :speciality
      t.text :content
      t.string :self_introduction
      t.string :conmapy_url
      t.string :contact
      t.references :user,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
