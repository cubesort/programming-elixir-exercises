handle_open = fn
  {:ok, file} -> "First line: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
end

# IO.puts handle_open.(File.open("./main.c"))

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
