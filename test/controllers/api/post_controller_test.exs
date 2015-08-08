defmodule ElixirFriends.API.PostControllerTest do
  use ElixirFriends.ConnCase
  alias ElixirFriends.Post

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "list all posts", %{conn: conn} do
    post = %Post{
      image_url: "http://elixirfriends.com",
      content: "This is some content",
      username: "knewter",
      source_url: "http://elixirfriends.com"
    }
    inserted_post = post |> ElixirFriends.Repo.insert!

    conn = get conn, "/api/posts"

    expected_response = %{
      total_pages: 1,
      total_entries: 1,
      page_size: 20,
      page_number: 1,
      entries: [inserted_post]
    } |> Poison.encode!

    assert json_response(conn, 200) == expected_response
  end
end
