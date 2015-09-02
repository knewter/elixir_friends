defmodule ElixirFriends.ImageTweetStreamer do
  import Ecto.Query, only: [from: 2]
  alias ElixirFriends.Post
  alias ElixirFriends.Repo

  def stream(search_term) do
    ExTwitter.stream_filter(track: search_term)
    |> Stream.filter(&has_images?/1)
    |> Stream.map(&conditionally_store_tweet/1)
  end

  defp has_images?(%ExTwitter.Model.Tweet{}=tweet) do
    Map.has_key?(tweet.entities, :media) &&
    Enum.any?(photos(tweet))
  end

  defp conditionally_store_tweet(%ExTwitter.Model.Tweet{}=tweet) do
    post = %Post{
      image_url: first_photo(tweet).media_url,
      content: tweet.text,
      source_url: first_photo(tweet).expanded_url,
      username: tweet.user.screen_name
    }
    unless post_exists?(post) do
      store_post(post)
    end
  end

  defp post_exists?(post) do
    query = from p in Post,
      where: p.image_url == ^post.image_url,
      select: count(p.id)

    Repo.one(query) > 0
  end

  def store_post(%ElixirFriends.Post{}=post) do
    IO.puts "storing this post: #{inspect post}"
    Repo.insert(post)
    ElixirFriends.Endpoint.broadcast! "posts:new", "new:post", post
  end

  defp photos(%ExTwitter.Model.Tweet{}=tweet) do
    tweet.entities.media
    |> Enum.filter(fn(medium) ->
      medium.type == "photo"
    end)
  end

  defp first_photo(%ExTwitter.Model.Tweet{}=tweet) do
    photos(tweet)
    |> hd
  end
end
