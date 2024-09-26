class ChangePackagePriceFromDecimalToInteger < ActiveRecord::Migration[7.2]
  def change
    change_column :packages, :price, :integer, null: false, default: 0
  end
end
