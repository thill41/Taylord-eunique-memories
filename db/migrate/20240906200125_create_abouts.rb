class CreateAbouts < ActiveRecord::Migration[7.2]
  def change
    create_table :abouts do |t|
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
