class CreatePackages < ActiveRecord::Migration[7.2]
  def change
    create_table :packages do |t|
      t.string :name, null: false, default: ''
      t.string :statement, null: false, default: ''
      t.decimal :price, precision: 10, scale: 2, null: false, default: 0.0
      t.text :description
      t.string :position, null: false, default: ''
      t.boolean :enabled, null: false, default: false

      t.timestamps
    end
  end
end
