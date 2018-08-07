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
IO.inspect MyList2.take([1, 2, 3, 4, 5], 3)
