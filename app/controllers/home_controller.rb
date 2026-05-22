class HomeController < ApplicationController
  def index
    begin
      @total_todos    = Todo.count
      @done_todos     = Todo.where(done: true).count
      @pending_todos  = Todo.where(done: [false, nil]).count
      @recent_todos   = Todo.order(created_at: :desc).limit(5)
      @completion_pct = @total_todos > 0 ? ((@done_todos.to_f / @total_todos) * 100).round : 0
    rescue
      @total_todos    = 0
      @done_todos     = 0
      @pending_todos  = 0
      @recent_todos   = []
      @completion_pct = 0
    end
  end
end
