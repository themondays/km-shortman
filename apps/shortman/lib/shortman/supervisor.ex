defmodule Shortman.Records.Supervisor do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(Shortman.Records.Cache, [[name: Shortman.Records.Cache]]),
      worker(Shortman.Records.QueryCache, [[name: Shortman.Records.QueryCache]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
