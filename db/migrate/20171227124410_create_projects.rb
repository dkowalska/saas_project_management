class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :details
      t.date :expected_start_date
      t.date :expected_completion_date
      t.references :tenant

      t.timestamps
    end
  end
end
