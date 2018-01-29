class AddTaskToArtifacts < ActiveRecord::Migration[5.1]
  def change
    add_reference :artifacts, :task, foreign_key: true
  end
end
