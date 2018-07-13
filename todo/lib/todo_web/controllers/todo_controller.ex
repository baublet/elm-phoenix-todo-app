defmodule TodoWeb.TodoController do
  use TodoWeb, :controller

  alias Todo.Items, as: TodoItems
  alias Todo.Items.Todo, as: TodoItem

  action_fallback TodoWeb.FallbackController

  def index(conn, _params) do
    todos = TodoItems.list_todos()
    render(conn, "index.json", todos: todos)
  end

  def create(conn, %{"todo" => todo_params}) do
    with {:ok, %TodoItem{} = todo} <- TodoItems.create_todo(todo_params) do
      conn
      |> put_status(:created)
      |> render("show.json", todo: todo)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = TodoItems.get_todo!(id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = TodoItems.get_todo!(id)

    with {:ok, %TodoItem{} = todo} <- TodoItems.update_todo(todo, todo_params) do
      render(conn, "show.json", todo: todo)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = TodoItems.get_todo!(id)
    with {:ok, %TodoItem{}} <- TodoItems.delete_todo(todo) do
      send_resp(conn, :no_content, "")
    end
  end
end
