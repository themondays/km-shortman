defmodule Shortman.Records.Cache do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(
      __MODULE__,
      [
        {:ets_table_name, :link_cache_table},
        {:log_limit, 1_000_000}
      ],
      opts
    )
  end

  def fetch(hashid, callback) do
    case get(hashid) do
      {:not_found} -> set(hashid, callback.())
      {:found, result} -> result
    end
  end

  defp get(hashid) do
    case GenServer.call(__MODULE__, {:get, hashid}) do
      [] -> {:not_found}
      [{_hashid, result}] -> {:found, result}
    end
  end

  defp set(hashid, value) do
    GenServer.call(__MODULE__, {:set, hashid, value})
  end

  def handle_call({:get, hashid}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.lookup(ets_table_name, hashid)
    {:reply, result, state}
  end

  def handle_call({:set, hashid, value}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    true = :ets.insert(ets_table_name, {hashid, value})
    {:reply, value, state}
  end

  def init(args) do
    [{:ets_table_name, ets_table_name}, {:log_limit, log_limit}] = args
    :ets.new(ets_table_name, [:named_table, :set, :private])
    {:ok, %{log_limit: log_limit, ets_table_name: ets_table_name}}
  end
end
