class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :street_address
      t.date :date_of_birth
      t.text :bio
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
