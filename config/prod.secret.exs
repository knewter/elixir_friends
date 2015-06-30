use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :elixir_friends, ElixirFriends.Endpoint,
  secret_key_base: "zM/nNR/YYc6PjmKKDPSK95A9w4TqvrWI3LWFkTCFt3fs1MrkypBjGzz66bXqFYhK"

# Configure your database
config :elixir_friends, ElixirFriends.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: System.get_env("DATABASE_URL"),
  size: 20 # The amount of database connections in the pool
