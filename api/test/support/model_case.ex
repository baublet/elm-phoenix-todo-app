defmodule Api.ModelCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias Api.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Api.ModelCase
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Api.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Api.Repo, {:shared, self()})
    end

    :ok
  end

  def errors_on(struct, data) do
    struct.__struct__.changeset(struct, data)
    |> Ecto.Changeset.traverse_errors(&Api.ErrorHelpers.translate_error/1)
    |> Enum.flat_map(fn {key, errors} -> for msg <- errors, do: {key, msg} end)
  end
end
