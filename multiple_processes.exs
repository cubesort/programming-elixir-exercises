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

defmodule MultipleProcesses2 do
  import :timer, only: [ sleep: 1 ]

  def self_exit(pid) do
    send(pid, "exit now")
    exit(:boom)
    # raise "exception"
  end

  def run do
    spawn_monitor(MultipleProcesses2, :self_exit, [self()])
    sleep(500)
    receive do
      message -> IO.puts("Message received: #{message}")
    end
  end
end

# MultipleProcesses2.run()
