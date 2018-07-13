defmodule Todo.ItemsTest do
  use Todo.DataCase

  alias Todo.Items

  describe "todos" do
    alias Todo.Items.Todo, as: TodoItem

    @valid_attrs %{completed: true, task: "some task", user: "some user"}
    @update_attrs %{completed: false, task: "some updated task", user: "some updated user"}
    @invalid_attrs %{completed: nil, task: nil, user: nil}

    def todos_fixture(attrs \\ %{}) do
      {:ok, todos} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Items.create_todo()

      todos
    end

    test "list_todos/0 returns all todos" do
      todos = todos_fixture()
      assert Items.list_todos() == [todos]
    end

    test "get_todo!/1 returns the todos with given id" do
      todos = todos_fixture()
      assert Items.get_todo!(todos.id) == todos
    end

    test "create_todo/1 with valid data creates a todos" do
      assert {:ok, %TodoItem{} = todos} = Items.create_todo(@valid_attrs)
      assert todos.completed == true
      assert todos.task == "some task"
      assert todos.user == "some user"
    end

    test "create_todo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_todo(@invalid_attrs)
    end

    test "update_todo/2 with valid data updates the todos" do
      todos = todos_fixture()
      assert {:ok, todos} = Items.update_todo(todos, @update_attrs)
      assert %TodoItem{} = todos
      assert todos.completed == false
      assert todos.task == "some updated task"
      assert todos.user == "some updated user"
    end

    test "update_todo/2 with invalid data returns error changeset" do
      todos = todos_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_todo(todos, @invalid_attrs)
      assert todos == Items.get_todo!(todos.id)
    end

    test "delete_todos/1 deletes the todos" do
      todos = todos_fixture()
      assert {:ok, %TodoItem{}} = Items.delete_todo(todos)
      assert_raise Ecto.NoResultsError, fn -> Items.get_todo!(todos.id) end
    end

    test "change_todo/1 returns a todos changeset" do
      todos = todos_fixture()
      assert %Ecto.Changeset{} = Items.change_todo(todos)
    end
  end
end
