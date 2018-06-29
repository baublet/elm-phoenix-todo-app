use Mix.Config

config :api, Api.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :api, Api.Repo,
  adapter: Sqlite.Ecto2,
  database: "ecto_simple.sqlite3"