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

# ListsAndRecursion-5

defmodule MyList2 do
  def all?(list), do: all?(list, &(!!&1))
  def all?([], _fun), do: true
  def all?([head | tail], fun) do
    if fun.(head) do
      all?(tail, fun)
    else
      false
    end
  end

  def each([], _fun), do: []
  def each([head | tail], fun), do: [fun.(head) | each(tail, fun)]

  def filter([], _fun), do: []
  def filter([head | tail], fun) do
    if fun.(head) do
      [head | filter(tail, fun)]
    else
      filter(tail, fun)
    end
  end

  # todo: handle negative count
  def split(list, count), do: split(list, [], count)
  defp split(tail, picked, 0), do: {Enum.reverse(picked), tail}
  defp split([], picked, _), do: {Enum.reverse(picked), []}
  defp split([head | tail], picked, count), do: split tail, [head | picked], count - 1

  def take(list, count) do
    {taken, _} = split(list, count)
    taken
  end

end

# IO.puts MyList2.all? [1, 2]
# IO.puts MyList2.all? [1, 2], &(&1 > 1)
# IO.inspect MyList2.each [1, 2], &(&1 + 1)
# IO.inspect(MyList2.filter [0, 1, 2, 3, 4], &(&1 > 1))
# IO.inspect MyList2.split [1, 2, 3, 4, 5], 2
# IO.inspect MyList2.split [1, 2, 3, 4, 5], 5
# IO.inspect MyList2.split [1, 2, 3, 4, 5], 8
# IO.inspect MyList2.take([1, 2, 3, 4, 5], 3)


# ListsAndRecursion-5

defmodule MyList3 do
  def flatten(list) do
    flatten(list, [])
      |> Enum.reverse
  end
  defp flatten([], flattened), do: flattened
  defp flatten([head | tail], flattened) when is_list(head), do: flatten(tail, flatten(head, []) ++ flattened)
  defp flatten([head | tail], flattened), do: flatten(tail, [head | flattened])

  def flatten1(list), do: flatten1(list, [])
  defp flatten1([], flattened), do: Enum.reverse flattened
  defp flatten1([[h | []] | tail], flattened), do: flatten1([h | tail], flattened)
  defp flatten1([[h | t] | tail], flattened), do: flatten1([h, t | tail], flattened)
  defp flatten1([head | tail], flattened), do: flatten1(tail, [head | flattened])

  def flatten2([]), do: []
  def flatten2([head | tail]), do: flatten2(head) ++ flatten2(tail)
  def flatten2(head), do: [head]
end

# IO.inspect(MyList3.flatten [[[1], 2], 3, [4, [5, 6, [7]]]])
# IO.inspect(MyList3.flatten1 [[[1, 2], 3], 4, [5, [6, [7, 8, 9]]]])
# IO.inspect(MyList3.flatten2 [[[1, 2], 3], 4, [5, [6, [7, 8, 9]]]])

# ListsAndRecursion-7

defmodule MyList7 do
  def print_primes(n) do
    for x <- MyList.span(3, n), rem(x, 2) !== 0, into: [2], do: x
  end
end

# IO.inspect MyList7.print_primes(5)

