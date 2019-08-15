defmodule MatchManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  alias MatchManager.MatchStore

  use Application

  def start(_type, _args) do
    children = [
      MatchManagerWeb.Endpoint,
      MatchStore
    ]

    opts = [strategy: :one_for_one, name: MatchManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    MatchManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
