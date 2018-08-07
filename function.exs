# functions-2

handle_open = fn
  {:ok, file} -> "First line: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
end

# IO.puts handle_open.(File.open("./main.c"))

# functions-3

fizz_buzz_helper = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, a -> a
end

# IO.puts fizz_buzz_helper.(1, 1, 1)

fizz_buzz = fn n ->
  fizz_buzz_helper.(rem(n, 3), rem(n, 5), n)
end

# IO.puts fizz_buzz.(10)
# IO.puts fizz_buzz.(11)
# IO.puts fizz_buzz.(12)

# functions-4

prefix = fn pre ->
  fn name -> "#{pre} #{name}" end
end

# mrs = prefix.("Mrs.")
# IO.puts mrs.("Smith")

# functions-5

# Enum.map [1, 2, 3, 4], &(&1 + 2)
# Enum.each [1, 2, 3, 4], &(IO.inspect &1)

cast = [
  %{
    actor: {"robin", "some"}
  },
  %{
    actor: {"john", "thing"}
  }
]

IO.inspect get_and_update_in(
  cast,
  [Access.all(), :actor, Access.elem(1)],
  &({&1, String.reverse(&1)})
)
