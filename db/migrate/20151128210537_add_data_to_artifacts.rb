class AddDataToArtifacts < ActiveRecord::Migration
  def change
    add_column :artifacts, :data, :string
  end
end
