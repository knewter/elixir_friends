defmodule ElixirFriends.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :image_url, :string
      add :content, :string
      add :source_url, :string

      timestamps
    end

  end
end
