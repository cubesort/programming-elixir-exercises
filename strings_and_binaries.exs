defmodule MyString do
  # StringsAndBinaries-1
  def printable?(charList) do
    Enum.all? charList, fn c -> c >= 32 && c <= 255 end
  end

  # StringsAndBinaries-2
  def anagram?(word1, word2) do
    set1 = MapSet.new word1
    set2 = MapSet.new word2
    MapSet.equal? set1, set2
  end

  # StringsAndBinaries-4
  @operators '-+*/'
  def calc(charList) do
    op = Enum.find(charList, nil, &(Enum.member?(@operators, &1)))
    numbers = Enum.chunk_by(charList, &(&1 === ?\s))
    first = parse_int(Enum.at(numbers, 0))
    last = parse_int(Enum.at(numbers, 4))
    operate(op, first, last)
  end

  def operate(?+, first, last), do: first + last
  def operate(?-, first, last), do: first - last
  def operate(?*, first, last), do: first * last
  def operate(?/, first, last), do: first / last

  def parse_int(charList), do: parse_int(charList, 0)
  defp parse_int([head | tail], value), do: parse_int(tail, value * 10 + head - ?0)
  defp parse_int([], value), do: value

  def center(stringList) do
    max = Enum.map(stringList, &(String.length(&1)))
      |> Enum.max()

    Enum.map(stringList, &(pad_string(&1, max)))
    |> Enum.each(&(IO.puts(&1)))
  end

  def pad_string(string, max) do
    left_padding = div(max + String.length(string), 2)
    string
    |> String.pad_leading(left_padding)
    |> String.pad_trailing(max)
  end

  # StringsAndBinaries-7
  def capitalize(string) do
    string
    |> String.split(". ")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(". ")
  end
end

# IO.puts MyString.printable? 'asd12'
# IO.puts MyString.anagram? 'asd12', '21ads'
# IO.puts MyString.calc('12 * 3')
# IO.puts(MyString.center(["123", "asdf", "fssdafkjlkjsldkfj"]))
# IO.puts(MyString.capitalize("oh. a DOG. woof. "))

defmodule OrderSystem do
  @tax_rates [
    NC: 0.075,
    TX: 0.08
  ]

  def get_totals(orders) do
    Enum.map(orders, &(add_total(&1)))
  end

  defp add_total([_, {_, ship_to}, {_, net_amount}] = order) do
    tax_rate = Keyword.get(@tax_rates, ship_to, 0) + 1
    order ++ [total_amount: tax_rate * net_amount]
  end

  def read_order(path) do
    { :ok, file } = File.open(path, [:read])
    { _, rates } =
      file
      |> IO.stream(:line)
      |> Enum.split(1)

    rates
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    [ id, ship_to, net_amount ] = String.trim(line) |> String.split(",")
    <<_::utf8, ship_to::binary>> = ship_to
    [ id: String.to_integer(id), ship_to: String.to_atom(ship_to), net_amount: String.to_float(net_amount) ]
  end
end

# IO.inspect OrderSystem.read_order("./order_data") |> OrderSystem.get_totals()
