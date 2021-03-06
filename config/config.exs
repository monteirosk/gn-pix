# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :pagamentos,
  ecto_repos: [Pagamentos.Repo]

# Configures the endpoint
config :pagamentos, PagamentosWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "dtLl/EA/zeUOVYZspE6cLNh/bJ5IuhqU4xpqMMyl2xu+nakA2NQxzzRYeCyR68Dl",
  render_errors: [view: PagamentosWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Pagamentos.PubSub,
  live_view: [signing_salt: "GGOGdZbQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
