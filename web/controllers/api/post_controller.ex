defmodule ElixirFriends.API.PostController do
  use ElixirFriends.Web, :controller
  import Ecto.Query

  alias ElixirFriends.Post

  plug :action

  def index(conn, params) do
    posts_page = Post
    |> order_by([p], desc: p.inserted_at)
    |> ElixirFriends.Repo.paginate(page: params["page"])

    render(conn, "index.json", posts_page: posts_page)
  end
end
