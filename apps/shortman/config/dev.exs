# Since configuration is shared in umbrella projects, this file
# should only configure the :shortman application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

# Configure your database
config :shortman, Shortman.Repo,
  username: "staging",
  password: "staging",
  database: "shortman_dev",
  hostname: "localhost",
  pool_size: 100
