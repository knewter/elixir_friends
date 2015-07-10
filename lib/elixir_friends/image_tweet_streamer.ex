defmodule ElixirFriends.ImageTweetStreamer do
  def stream(search_term) do
    ExTwitter.stream_filter(track: search_term)
    |> Stream.filter(&has_images?/1)
    |> Stream.map(&store_tweet/1)
  end

  defp has_images?(%ExTwitter.Model.Tweet{}=tweet) do
    Map.has_key?(tweet.entities, :media) &&
    Enum.any?(photos(tweet))
  end

  defp store_tweet(%ExTwitter.Model.Tweet{}=tweet) do
    IO.puts "storing this tweet: #{inspect(tweet, pretty: true, limit: 2_000)}"
    post = %ElixirFriends.Post{
      image_url: first_photo(tweet).media_url,
      content: tweet.text,
      source_url: first_photo(tweet).expanded_url,
      username: tweet.user.screen_name
    }
    IO.puts "storing this post: #{inspect post}"
    ElixirFriends.Repo.insert(post)
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
