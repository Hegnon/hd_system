class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name, limit: 50
      t.string :description, limit: 120

      t.timestamps
    end
    add_index :profiles, :name, unique: true
  end
end
