defmodule ElixirFriends.Repo do
  use Ecto.Repo, otp_app: :elixir_friends
  use Scrivener, page_size: 20
  use Beaker.Integrations.Ecto
end
