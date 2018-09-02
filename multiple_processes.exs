defmodule MultipleProcesses do
  def greet do
    receive do
      { sender, token } ->
        send sender, { self(), token }
    end
  end

  def create_processes(tokens) do
    Enum.each(tokens, fn token ->
      pid = spawn(MultipleProcesses, :greet, [])
      send(pid, { self(), token })
      receive do {^pid, token} -> IO.puts token end
    end)
  end
end

# MultipleProcesses.create_processes(["john", "betty"])
