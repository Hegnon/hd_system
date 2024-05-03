class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, limit: 60
      t.string :password_digest
      t.string :name, limit: 50
      t.references :profile, null: false, foreign_key: true
      t.integer :status

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
