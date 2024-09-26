class AddOutputToPurchases < ActiveRecord::Migration[7.2]
  def change
    add_column :purchases, :output, :text
  end
end
