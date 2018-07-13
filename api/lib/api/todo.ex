defmodule Api.Todo do
  use Ecto.Schema
  import Ecto.Changeset


  schema "todos" do
    field :completed, :boolean, default: false
    field :todo, :string, required: true
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:user, :todo, :completed])
    |> validate_required([:user, :todo, :completed])
  end
end
