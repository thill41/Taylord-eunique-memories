class CreatePurchases < ActiveRecord::Migration[7.2]
  def change
    create_table :purchases do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :package, null: false, foreign_key: true
      t.string :stripe_payment_id
      t.string :status

      t.timestamps
    end
  end
end
