defmodule ElixirFriends.Repo.Migrations.AddUsernameToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :username, :string
    end
  end
end
