class CreateTodos < ActiveRecord::Migration[7.2]
  def change
    create_table :todos do |t|
      t.string :title
      t.string :description
      t.boolean :done

      t.timestamps
    end
  end
end
