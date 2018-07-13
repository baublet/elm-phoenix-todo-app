defmodule Todo.Items do
  @moduledoc """
  The Items context.
  """

  import Ecto.Query, warn: false
  alias Todo.Repo

  alias Todo.Items.Todo

  @doc """
  Returns the list of todos.
  """
  def list_todos do
    Repo.all(Todo)
  end

  @doc """
  Gets a single todos.

  Raises `Ecto.NoResultsError` if the Todos does not exist.
  """
  def get_todo!(id), do: Repo.get!(Todo, id)

  @doc """
  Creates a todo.
  """
  def create_todo(attrs \\ %{}) do
    %Todo{}
    |> Todo.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a todo
  """
  def update_todo(%Todo{} = todo, attrs) do
    todo
    |> Todo.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a todo
  """
  def delete_todo(%Todo{} = todo) do
    Repo.delete(todo)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo changes.
  """
  def change_todo(%Todo{} = todo) do
    Todo.changeset(todo, %{})
  end
end
