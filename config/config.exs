# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :master_key,
  ecto_repos: [MasterKey.Repo]

# Configures the endpoint
config :master_key, MasterKeyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jTuiO+NuausJWmlQtUv8y7rf1KJ+bWdtLp+nrfx90lhwSo5eRU41GmQIznu4q8W8",
  render_errors: [view: MasterKeyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: MasterKey.PubSub,
  live_view: [signing_salt: "X9iSBb49"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
