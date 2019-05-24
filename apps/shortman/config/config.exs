# Since configuration is shared in umbrella projects, this file
# should only configure the :shortman application itself
# and only for organization purposes. All other config goes to
# the umbrella root.
use Mix.Config

config :shortman,
  ecto_repos: [Shortman.Repo]

import_config "#{Mix.env()}.exs"
