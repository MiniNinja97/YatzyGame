defmodule YatzyWeb.YatzyLive do
  use YatzyWeb, :live_view
  alias Yatzy.Game


  def mount(_params, _session, Socket) do
    {:ok, assign(socket, game: Game.new_game())}
  end

  def handle_event("roll", _, socket) do
    {:noreply, assign(socket, game: new_game)}
  end
end

def handle_event("toggle_save", %{"index" => index}, socket) do
  index = String.to_integer(index)
  new_game = Game.toggle_save(socket.assigns.game, index)
  {:noreply, assign(socket, game: new_game)}
end

def handle_event("reset", _, socket) do
  new_game = Game.reset(socket.assigns.game)
  {:noreply, assign(socket, game: new_game)}
end

def render(assigns) do
  ~H"""

  <div>
  <h2> Yatzy </h2>
  <p> Kast kvar: <%=@game.rolls_left %</p>
  <div style="display: flex; gap: 10px;">
        <%= for {die, idx} <- Enum.with_index(@game.dice) do %>
          <button
            phx-click="toggle_save"
            phx-value-index={idx}
            style={"width: 50px; height: 50px; font-size: 20px; background-color: #{if Enum.at(@game.saved, idx), do: "lightgreen", else: "white"}"}
          >
            <%= die %>
          </button>
        <% end %>
      </div>

      <br />
      <button phx-click="roll" disabled={@game.rolls_left == 0}>Kasta</button>
      <button phx-click="reset">Reset</button>

  </div>
  """
end
