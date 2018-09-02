defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> send next_pid, n + 1
    end
  end

  def create_processes(n) do
    reducer = fn (_, send_to) ->
      spawn(Chain, :counter, [send_to])
    end

    last = Enum.reduce(1..n, self(), reducer)

    send(last, 0)

    receive do
      final_anwser -> "Result is #{inspect(final_anwser)}"
    end
  end

  def run(n) do
    :timer.tc(Chain, :create_processes, [n])
    |> IO.inspect
  end
end
