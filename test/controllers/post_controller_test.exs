defmodule ElixirFriends.PostControllerTest do
  use ElixirFriends.ConnCase

  alias ElixirFriends.Post
  @valid_attrs %{content: "some content", image_url: "some content", source_url: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  @tag skip: "outdated"
  # test "lists all entries on index", %{conn: conn} do
  #   conn = get conn, post_path(conn, :index)
  #   assert html_response(conn, 200) =~ "Create and share together."
  # end
end
