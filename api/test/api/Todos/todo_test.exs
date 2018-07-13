defmodule Api.Todos.TodoTest do
  use Api.ModelCase

  alias Api.Todo

  @valid_attrs %{completed: false, todo: "This is a todo", user: "baublet"}
  @invalid_attrs %{gorilla: "banana"}

  test "changeset with valid attributes" do
    changeset = Todo.changeset(%Todo{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Todo.changeset(%Todo{}, @invalid_attrs)
    refute changeset.valid?
  end
end