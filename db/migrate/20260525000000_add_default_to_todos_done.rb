class AddDefaultToTodosDone < ActiveRecord::Migration[7.2]
  def change
    change_column_default :todos, :done, from: nil, to: false
  end
end
