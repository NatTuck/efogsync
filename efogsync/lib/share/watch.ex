defmodule Share.Watch do
  use GenServer

  # Interface
  def start(path) do
    GenServer.start_link(Share.Watch, %{path: path})
  end

  # Callbacks
  
  def init(%{path: path}) do
    %Porcelain.Process{pid: pid} = Porcelain.spawn_shell(
      ~s(stdbuf -oL inotifywait -qmr "#{path}"), out: {:send, self})
    {:ok, %{path: path, pid: pid, fans: []}}
  end

  def handle_info({_, :data, :out, msg}, state) do
    events = 
    msg
    |> String.strip
    |> String.split("\n")
    |> Enum.map(fn(item) ->
      [dir, ev, name] = String.split(item, ~r(\s+))
      {ev, dir, name}
    end)
    
    IO.inspect events

    {:noreply, state}
  end
end
