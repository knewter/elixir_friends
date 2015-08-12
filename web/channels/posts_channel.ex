defmodule ElixirFriends.PostsChannel do
  use Phoenix.Channel

  def join("posts:new", _auth_msg, socket) do
    {:ok, socket}
  end
end
