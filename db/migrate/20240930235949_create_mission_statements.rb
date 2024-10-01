class CreateMissionStatements < ActiveRecord::Migration[7.2]
  def change
    create_table :mission_statements do |t|
      t.references :user, null: false, foreign_key: true
      t.string :statemet, null: false, default: ''

      t.timestamps
    end
  end
end
