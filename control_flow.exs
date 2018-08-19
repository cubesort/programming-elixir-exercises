defmodule ControlFlow do
  def fizz_buzz(n) do
    1..n |> Enum.map(&fizz_buzz_helper/1)
  end

  def fizz_buzz_helper(n) do
    case { rem(n, 3), rem(n, 5) } do
      { 0, 0 } -> "FizzBuzz"
      { 0, _ } -> "Fizz"
      { _, 0 } -> "Buzz"
      _ -> n
    end
  end
end

IO.inspect(ControlFlow.fizz_buzz(20))
