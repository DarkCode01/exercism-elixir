defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    v = 
      Enum.to_list(1..number)
      |> Enum.reverse
      |> Enum.map_join(" ", &do_end/1)

    "On the #{do_open(number)} day of Christmas my true love gave to me: #{v}."
  end

  def do_open(1), do: "first"
  def do_open(2), do: "second"
  def do_open(3), do: "third"
  def do_open(4), do: "fourth"
  def do_open(5), do: "fifth"
  def do_open(6), do: "sixth"
  def do_open(7), do: "seventh"
  def do_open(8), do: "eighth"
  def do_open(9), do: "ninth"
  def do_open(10), do: "tenth"
  def do_open(11), do: "eleventh"
  def do_open(12), do: "twelfth"

  def do_end(1), do: "a Partridge in a Pear Tree"
  def do_end(2), do: "two Turtle Doves, and"
  def do_end(3), do: "three French Hens,"
  def do_end(4), do: "four Calling Birds,"
  def do_end(5), do: "five Gold Rings,"
  def do_end(6), do: "six Geese-a-Laying,"
  def do_end(7), do: "seven Swans-a-Swimming,"
  def do_end(8), do: "eight Maids-a-Milking,"
  def do_end(9), do: "nine Ladies Dancing,"
  def do_end(10), do: "ten Lords-a-Leaping,"
  def do_end(11), do: "eleven Pipers Piping,"
  def do_end(12), do: "twelve Drummers Drumming,"

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Enum.to_list
    |> Enum.map_join("\n", &verse/1)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end