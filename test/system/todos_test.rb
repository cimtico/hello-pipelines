require "application_system_test_case"

class TodosTest < ApplicationSystemTestCase
  setup do
    @todo = todos(:one)
  end

  test "visiting the index" do
    visit todos_url
    assert_selector "h1", text: "Todos"
  end

  test "should create todo" do
    visit todos_url
    click_on "+ New Todo"

    fill_in "Description", with: @todo.description
    check "Mark as done" if @todo.done
    fill_in "Title", with: @todo.title
    click_on "Create Todo"

    assert_text "Todo was successfully created"
    click_on "Back to Todos"
  end

  test "should update Todo" do
    visit todo_url(@todo)
    click_on "Edit", match: :first

    fill_in "Description", with: @todo.description
    check "Mark as done" if @todo.done
    fill_in "Title", with: @todo.title
    click_on "Update Todo"

    assert_text "Todo was successfully updated"
    click_on "Back to Todos"
  end

  test "should destroy Todo" do
    visit todo_url(@todo)
    click_on "Delete", match: :first

    assert_text "Todo was successfully destroyed"
  end
end
