defmodule MatchManagerWeb.Router do
  use MatchManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MatchManagerWeb do
    pipe_through :api

    get "/matches", MatchController, :list_matches
    get "/matches/:div/:season", MatchController, :show_matches

    get "/matches/proto", MatchController, :list_matches_proto
    get "/matches/proto/:div/:season", MatchController, :show_matches_proto
  end
end
