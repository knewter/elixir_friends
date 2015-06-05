defmodule ElixirFriends.PageController do
  use ElixirFriends.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
