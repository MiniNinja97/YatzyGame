defmodule YatzyGame.Repo do
  use Ecto.Repo,
    otp_app: :yatzy_game,
    adapter: Ecto.Adapters.Postgres
end
