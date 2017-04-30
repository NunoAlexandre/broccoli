# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :broccoli,
  ecto_repos: [Broccoli.Repo]

# Authentication Configuration
config :doorman,
  repo: Broccoli.Repo,
  secure_with: Doorman.Auth.Bcrypt,
  user_module: Broccoli.User

# Configures the endpoint
config :broccoli, Broccoli.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "scBwVnygA54MhO86fnatuU9chV4JweHwFMIa82wRAnv97y/iv2cd32sxORHb56xY",
  render_errors: [view: Broccoli.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Broccoli.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"