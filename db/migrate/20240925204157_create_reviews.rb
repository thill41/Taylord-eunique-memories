class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :rating
      t.text :content

      t.timestamps
    end
  end
end
