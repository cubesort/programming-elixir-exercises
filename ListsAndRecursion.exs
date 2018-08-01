defmodule MyList do
  def mapsum(list, fun), do: mapsum(list, fun, 0)
  def mapsum([], _fun, sum), do: sum
  def mapsum([head | tail], fun, sum), do: mapsum(tail, fun, fun.(head) + sum)

  def max([one]), do: one
  def max([head | tail]), do: Kernel.max(head, max(tail))

  def caesar([], _n), do: []
  def caesar([head | tail], n) when head + n <= ?z, do: [head + n | caesar(tail, n)]
  def caesar([head | tail], n), do: [head + n - 26 | caesar(tail, n)]
end

# IO.puts MyList.mapsum [1, 2, 3], &(&1 * &1)

# IO.puts MyList.max [2, 3, 11, 9, 4]

# IO.puts MyList.caesar('xyzabcd', 3)
