class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :role, null: false, default: 'user'
      t.string :email, null: false
      t.string :full_name, null: false
      t.date :birth_date, null: false
      t.text :small_biography, null: false
      t.string :avatar

      t.index :email, unique: true

      t.timestamps
    end
  end
end
