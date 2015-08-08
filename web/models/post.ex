defmodule ElixirFriends.Post do
  use ElixirFriends.Web, :model

  schema "posts" do
    field :image_url, :string
    field :content, :string
    field :source_url, :string
    field :username, :string

    timestamps
  end

  @required_fields ~w(image_url content source_url)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

defimpl Poison.Encoder, for: ElixirFriends.Post do
  def encode(post, _options) do
    post
    |> Map.from_struct
    |> Map.delete(:__meta__)
    |> Poison.encode!
  end
end
