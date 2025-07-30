defmodule Yatzy.Game do
  defstructure dice: [0, 0, 0, 0, 0],
  saved: [false, false, false, false, false],
  rolls_left: 3

  def new_game do
    %Yatzy.Game{}
  end

  def roll(%Yatzy.Game{dice: dice, saved: saved, rolls_left: rolls_left} = game) when rolls_left > 0 do
    new_dice = Enum.with_index(dice)
    |> Enum.map(fn {value, idx} ->
      if Enum.at(saved, idx), do: value, else: :rand.uniform(6)

    end)
    
  end
end
