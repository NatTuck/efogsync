# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :efserv, Efserv.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "ZVds2xmPvHWzL52DMxpOq2udlu/y+0RrguEXlWqEFvLWLivYC3Z7wYa4da6MmzIG",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Efserv.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :aeacus, Aeacus,
  repo: Efserv.Repo,
  model: Efserv.User,
  crypto: Comeonin.Pbkdf2,
  identity_field: :email,
  password_field: :hash,
  error_message: "Invalid identity or password."
