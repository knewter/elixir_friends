defmodule Integration.PostsTest do
  use ExUnit.Case
  use Hound.Helpers
  alias ElixirFriends.Post
  alias ElixirFriends.ImageTweetStreamer
  hound_session

  @post %Post{
    image_url: "http://elixirsips.com/images/194_Interoperability_Ports_Screenshot.png",
    content: "Fake content",
    source_url: "http://elixirsips.com",
    username: "knewter"
  }

  test "loading the home page" do
    navigate_to "http://localhost:4001/"
    assert page_source =~ "ElixirFriends"
  end

  test "seeing posts on the home page" do
    ImageTweetStreamer.store_post(@post)
    navigate_to "http://localhost:4001/"
    assert page_source =~ @post.content
  end

  test "new posts are injected onto the page" do
    navigate_to "http://localhost:4001/"
    this_post = %Post{ @post | content: "this post"}
    ImageTweetStreamer.store_post(this_post)
    assert page_source =~ this_post.content
  end
end
