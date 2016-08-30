defmodule ElixirFriends do
  use Application
  import Supervisor.Spec

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    term = Application.get_env(:elixir_friends, :term)

    children = [
      # Start the endpoint when the application starts
      supervisor(ElixirFriends.Endpoint, []),
      # Start the Ecto repository
      supervisor(ElixirFriends.Repo, []),
      worker(Task, [fn -> ElixirFriends.ImageTweetStreamer.stream(term) |> Stream.run end])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirFriends.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirFriends.Endpoint.config_change(changed, removed)
    :ok
  end
end
