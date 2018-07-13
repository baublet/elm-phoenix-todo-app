defmodule Todo.Items.Todos do
  use Ecto.Schema
  import Ecto.Changeset


  schema "todos" do
    field :completed, :boolean, default: false
    field :task, :string
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(todos, attrs) do
    todos
    |> cast(attrs, [:user, :task, :completed])
    |> validate_required([:user, :task, :completed])
  end
end
