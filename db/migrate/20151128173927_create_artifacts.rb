class CreateArtifacts < ActiveRecord::Migration
  def change
    create_table :artifacts do |t|
      t.integer :user
      t.string :msg

      t.timestamps null: false
    end
  end
end
