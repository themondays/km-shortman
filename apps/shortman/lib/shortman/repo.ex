defmodule Shortman.Repo do
  use Ecto.Repo,
    otp_app: :shortman,
    adapter: Ecto.Adapters.Postgres
end
