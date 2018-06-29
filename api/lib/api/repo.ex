defmodule Api.Repo do
  use Ecto.Repo,
    otp_app: :api,
    adapter: Sqlite.Ecto2
end
