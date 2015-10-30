# ElixirFriends

[![Build Status](https://semaphoreci.com/api/v1/projects/71585fd1-ee12-4e4d-bd95-65de262579c5/509767/badge.svg)](https://semaphoreci.com/knewter/elixir_friends)

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit `localhost:4000` from your browser.

## Buildpack

This uses [the phoenix static buildpack.](https://github.com/gjaldon/phoenix-static-buildpack)

## ExTwitter.Model.Tweet structure

We are going to be streaming ExTwitter.Model.Tweets into our database.  The
structure of one of those is as follows:

```
%ExTwitter.Model.Tweet{contributors: nil, coordinates: nil,
 created_at: "Thu Jul 02 12:41:00 +0000 2015",
 entities: %{hashtags: [], symbols: [],
   urls: [%{display_url: "bit.ly/1GQjkm6",
      expanded_url: "http://bit.ly/1GQjkm6", indices: 'Qg',
      url: "http://t.co/glk1sfwhDz"}], user_mentions: []}, favorite_count: 0,
 favorited: false, geo: nil, id: 616587375062290432,
 id_str: "616587375062290432", in_reply_to_screen_name: nil,
 in_reply_to_status_id: nil, in_reply_to_status_id_str: nil,
 in_reply_to_user_id: nil, in_reply_to_user_id_str: nil, lang: "en", place: nil,
 retweet_count: 0, retweeted: false,
 source: "<a href=\"http://twitterfeed.com\" rel=\"nofollow\">twitterfeed</a>",
 text: "lang/elixir/bsd.elixir.mk @ 391136: Add helper makefile for Elixir applications. http://t.co/glk1sfwhDz",
 truncated: false,
 user: %ExTwitter.Model.User{contributors_enabled: false, utc_offset: -14400,
  following: false, follow_request_sent: false, id_str: "2218195068",
  profile_background_color: "C0DEED",
  profile_image_url: "http://pbs.twimg.com/profile_images/378800000812206542/e0e817590ddd46782ffbe848a4244d88_normal.png",
  followers_count: 39,
  description: "Tweets of FreeBSD Ports code changes, managed by @swills",
  default_profile: true,
  entities: %{description: %{urls: []},
    url: %{urls: [%{display_url: "src.mouf.net/ports",
         expanded_url: "http://src.mouf.net/ports", indices: [0, 22],
         url: "http://t.co/ZYzYhwEh4z"}]}},
  created_at: "Wed Nov 27 17:54:25 +0000 2013", location: "",
  geo_enabled: false, statuses_count: 567, name: "FreeBSD Ports",
  screen_name: "fbsdports", profile_sidebar_border_color: "C0DEED",
  profile_background_tile: false, time_zone: "Eastern Time (US & Canada)",
  default_profile_image: false, friends_count: 1, favourites_count: 0,
  is_translator: false, id: 2218195068, lang: "en",
  profile_background_image_url_https: "https://abs.twimg.com/images/themes/theme1/bg.png",
  notifications: false,
  profile_background_image_url: "http://abs.twimg.com/images/themes/theme1/bg.png",
  listed_count: 6, is_translation_enabled: false, protected: false,
  profile_image_url_https: "https://pbs.twimg.com/profile_images/378800000812206542/e0e817590ddd46782ffbe848a4244d88_normal.png",
  profile_text_color: "333333", profile_sidebar_fill_color: "DDEEF6",
  verified: false, profile_link_color: "0084B4",
  profile_use_background_image: true, url: "http://t.co/ZYzYhwEh4z"}}
```

We store the tweet body, the image url, and the source url for each tweet.

## React and API bits

There's currently an API and a React-based UI that fetches the latest page of
tweets and renders it, and then handles any incoming tweets from Phoenix
Channels by live-updating the view.  The API supports pagination but since
transitioning to a React and live-updating frontend the app doesn't presently
have pagination links.

## TODO

- [ ] Convince someone to contribute a pretty UI
- [ ] Add pagination links within React application
