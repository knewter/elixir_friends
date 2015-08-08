defmodule ElixirFriends.API.PostView do
  use ElixirFriends.Web, :view

  def render("index.json", %{posts_page: posts_page}) do
    posts_page
    |> Poison.encode!
  end
end
