# Since configuration is shared in umbrella projects, this file
# should only configure the :shortman_api application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# General application configuration
config :shortman_api,
  namespace: ShortmanAPI,
  ecto_repos: [Shortman.Repo],
  generators: [context_app: :shortman]

# Configures the endpoint
config :shortman_api, ShortmanAPI.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "iuuJQKjhlwynjSA8IKf/yc4hejXGqt5XM9Hs1M9kz/IdqwknX2quW9x0PBvbgOMT",
  render_errors: [view: ShortmanAPI.ErrorView, accepts: ~w(json)],
  pubsub: [name: ShortmanAPI.PubSub, adapter: Phoenix.PubSub.PG2]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
