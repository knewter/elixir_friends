defmodule ElixirFriends.PostsChannelTest do
  use ElixirFriends.ChannelCase
  alias ElixirFriends.ImageTweetStreamer
  alias ElixirFriends.Post
  alias ElixirFriends.UserSocket

  test "new posts are pushed to the posts channel on the posts:new topic" do
    {:ok, socket} = connect(UserSocket, %{})
    {:ok, _, socket} = subscribe_and_join(socket, "posts:new", %{})
    post = %Post{content: "foo", image_url: "bar"}
    ImageTweetStreamer.store_post(post)
    assert_broadcast "new:post", post
  end
end
