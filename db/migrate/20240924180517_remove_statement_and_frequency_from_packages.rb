class RemoveStatementAndFrequencyFromPackages < ActiveRecord::Migration[7.2]
  def change
    remove_column :packages, :statement, :string
    remove_column :packages, :frequency, :string
  end
end