defmodule Todo.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :user, :string
      add :task, :string
      add :completed, :boolean, default: false, null: false

      timestamps()
    end

  end
end
