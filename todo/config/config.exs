# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :todo,
  ecto_repos: [Todo.Repo]

# Configures the endpoint
config :todo, TodoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "2hbNNVW2kCqrn3IX6idMlmp42ickQyplgRl4VFpydezcnxDfMx/EeB8flHTc6krx",
  render_errors: [view: TodoWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Todo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :todo, Todo.Repo,
  adapter: Sqlite.Ecto2,
  database: "ecto_simple.sqlite3"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
