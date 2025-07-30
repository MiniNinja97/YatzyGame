defmodule Yatzy.Game do
  defstruct dice: [0, 0, 0, 0, 0],
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
    %Yatzy.Game{game | dice: new_dice, rolls_left: rolls_left - 1}
  end
  def toggle_save(%Yatzy.Game{saved: saved} = game, index) when index in 0..4 do
    new_saved = List.update_at(saved, index fn val -> not val end)
    %Yatzy.Game{game | saved: new_saved}
  end

  def no_rolls?(%Yatzy.Game{rolls_left: rolls_left}), do: rolls_left == 0

  def reset(_game), do: new_game()
end
