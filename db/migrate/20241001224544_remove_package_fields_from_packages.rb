class RemovePackageFieldsFromPackages < ActiveRecord::Migration[7.2]
  def change
    remove_column :packages, :name, :string
    remove_column :packages, :description, :text
  end
end
