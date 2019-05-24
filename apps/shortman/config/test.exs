# Since configuration is shared in umbrella projects, this file
# should only configure the :shortman application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# Configure your database
config :shortman, Shortman.Repo,
  username: "staging",
  password: "staging",
  database: "staging",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
