# Since configuration is shared in umbrella projects, this file
# should only configure the :shortman_web application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :shortman_web,
  ecto_repos: [Shortman.Repo],
  generators: [context_app: :shortman]

# Configures the endpoint
config :shortman_web, ShortmanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "T7ui0NLIiNfSEV1lGOOS4Y5pqbkHsgB7z+y23P9by3p6Jvo5fsg5zCnHI7rCWesu",
  render_errors: [view: ShortmanWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ShortmanWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
