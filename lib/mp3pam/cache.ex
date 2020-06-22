defmodule MP3Pam.Cache do
  use GenServer

  @table :mp3pam_cache

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    :ets.new(@table, [
      :set,
      :public,
      :named_table,
      read_concurrency: true
      # write_concurrency: true
    ])

    {:ok, state}
  end

  def delete(key) do
    GenServer.cast(__MODULE__, {:delete, key})
  end

  def get(key, default \\ nil) do
    case GenServer.call(__MODULE__, {:get, key}) do
      nil ->
        if is_function(default) do
          data = default.()

          put(key, data)

          data
        else
          default
        end

      data ->
        data
    end
  end

  def put(key, data) do
    GenServer.cast(__MODULE__, {:put, key, data})
  end

  def handle_cast({:delete, key}, state) do
    :ets.delete(@table, key)
    {:noreply, state}
  end

  def handle_cast({:put, key, data}, state) do
    :ets.insert(@table, {key, data})

    {:noreply, state}
  end

  def handle_call({:get, key}, _from, state) do
    reply =
      case :ets.lookup(@table, key) do
        [] -> nil
        [{_key, data}] -> data
      end

    {:reply, reply, state}
  end
end
