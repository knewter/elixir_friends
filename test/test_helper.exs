ExUnit.start

# Create the database, run migrations, and start the test transaction.
Mix.Task.run "ecto.create", ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]
Ecto.Adapters.SQL.begin_test_transaction(ElixirFriends.Repo)

# Start hound for integration tests...
Application.ensure_all_started(:hound)

# Start chromedriver
#Port.open("chromedriver", []) # Can't do this until we can make sure this executable closes when the port dies - look into spawnkillable
