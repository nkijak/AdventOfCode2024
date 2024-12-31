defmodule Day13 do
  def parser(line, operator) do
    [_, movement] = String.split(line, ": ")
    {rawx,rawy} = String.split(movement, ", ") |> List.to_tuple
    # TODO watch them add "-" in step 2
    {_, x} = String.split(rawx, operator) |> List.to_tuple
    {_, y} = String.split(rawy, operator) |> List.to_tuple
    [x,y]
      |> Enum.map(& Integer.parse(&1) |> elem(0))
      |> List.to_tuple
  end

  def parse_machine(machine) do
    [a,b,p] = machine
    [coord_a, coord_b]  = [a,b] |> Enum.map(& parser(&1, "+"))

    %{:a => coord_a, :b => coord_b, :prize => parser(p, "=")}
  end

  def parse(lines) do
    chunkfn = fn el, acc ->
      if el == "" do
        {:cont, acc, []}
      else
        {:cont, acc ++ [el]}
      end
    end

    afterfn = fn
      [] -> {:cont, []}
      acc -> {:cont, acc, []}
    end

    lines
    |> Enum.chunk_while([],chunkfn, afterfn)
    |> Enum.map(& Day13.parse_machine/1)
  end

  def solve(%{a: {ax,ay}, b: {bx,by}, prize: {px, py}}) do
    b = (py * by)/(ax * 2) - px/2 * bx/2
    a = (px - b*bx)/ax
    {a,b}
  end
end
