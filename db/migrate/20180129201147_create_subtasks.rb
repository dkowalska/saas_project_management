class CreateSubtasks < ActiveRecord::Migration[5.1]
  def change
    create_table :subtasks do |t|
      t.text :description
      t.references :user, foreign_key: true
      t.references :tenant, foreign_key: true
      t.references :task, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
