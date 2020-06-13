defmodule MP3Pam.Cache do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: MP3PamCache)
  end

  def init(state) do
    :ets.new(:mp3pam_cache, [:set, :public, :named_table])
    {:ok, state}
  end

  def delete(key) do
    GenServer.cast(MP3PamCache, {:delete, key})
  end

  def get(key, default \\ nil) do
    case GenServer.call(MP3PamCache, {:get, key}) do
      nil ->
        cond do
          is_function(default) ->
            data = default.()

            put(key, data)

            data

          true ->
            default
        end

      data ->
        data
    end
  end

  def put(key, data) do
    GenServer.cast(MP3PamCache, {:put, key, data})
  end

  def handle_cast({:delete, key}, state) do
    :ets.delete(:mp3pam_cache, key)
    {:noreply, state}
  end

  def handle_cast({:put, key, data}, state) do
    :ets.insert(:mp3pam_cache, {key, data})

    {:noreply, state}
  end

  def handle_call({:get, key}, _from, state) do
    reply =
      case :ets.lookup(:mp3pam_cache, key) do
        [] -> nil
        [{_key, data}] -> data
      end

    {:reply, reply, state}
  end
end
