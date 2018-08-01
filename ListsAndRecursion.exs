defmodule MyList do
  def mapsum([], _fun), do: 0
  def mapsum([head | tail], fun), do: fun.(head) + mapsum(tail, fun)

  def max([one]), do: one
  def max([head | tail]), do: Kernel.max(head, max(tail))

  def caesar([], _n), do: []
  def caesar([head | tail], n) when head + n <= ?z, do: [head + n | caesar(tail, n)]
  def caesar([head | tail], n), do: [head + n - 26 | caesar(tail, n)]

  def span(from, from), do: [from]
  def span(from, to) when from < to, do: [from | span(from + 1, to)]
end

# IO.puts MyList.mapsum [1, 2, 3], &(&1 * &1)
# IO.puts MyList.max [2, 3, 11, 9, 4]
# IO.puts MyList.caesar 'xyzabcd', 3
# IO.puts MyList.span 2, 10
