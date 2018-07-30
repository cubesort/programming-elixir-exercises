defmodule Chop do
  def guess(actual, range = a..b) do
    guess = div(a + b, 2)
    IO.puts "Is it #{guess}"
    guess actual, range, guess
  end

  defp guess(actual, _, actual) do
    IO.puts actual
  end

  defp guess(actual, _a..b, guess) when guess < actual do
    guess actual, guess + 1..b
  end

  defp guess(actual, a.._b, guess) when guess > actual do
    guess actual, a..guess - 1
  end
end

# Chop.guess(273, 1..1000)
