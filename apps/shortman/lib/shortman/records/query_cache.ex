defmodule Shortman.Records.QueryCache do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(
      __MODULE__,
      [
        {:ets_table_name, :query_cache_table},
        {:log_limit, 1_000_000}
      ],
      opts
    )
  end

  def fetch(url, callback) do
    case get(url) do
      {:not_found} -> set(url, callback.())
      {:found, result} -> result
    end
  end

  defp get(url) do
    case GenServer.call(__MODULE__, {:get, url}) do
      [] -> {:not_found}
      [{_hashid, result}] -> {:found, result}
    end
  end

  defp set(url, value) do
    GenServer.call(__MODULE__, {:set, url, value})
  end

  def handle_call({:get, url}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    result = :ets.lookup(ets_table_name, url)
    {:reply, result, state}
  end

  def handle_call({:set, url, value}, _from, state) do
    %{ets_table_name: ets_table_name} = state
    true = :ets.insert(ets_table_name, {url, value})
    {:reply, value, state}
  end

  def init(args) do
    [{:ets_table_name, ets_table_name}, {:log_limit, log_limit}] = args
    :ets.new(ets_table_name, [:named_table, :set, :private])
    {:ok, %{log_limit: log_limit, ets_table_name: ets_table_name}}
  end
end
