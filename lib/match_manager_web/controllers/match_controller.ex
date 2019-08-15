defmodule MatchManagerWeb.MatchController do
  use MatchManagerWeb, :controller

  alias MatchManager.MatchStore
  alias MatchManager.Protobuf.Season

  def list_matches(conn, _params) do
    case MatchStore.list_data_json() do
      {:ok, matches} ->
        render(conn, "index.json", matches: matches)

      {:error, reason} ->
        render(conn, "error.json", %{reason: reason})
    end
  end

  def show_matches(conn, %{"div" => div, "season" => season}) do
    case MatchStore.find_matches(div, season) do
      {:ok, matches} ->
        render(conn, "show.json", %{div: div, season: season, matches: matches})

      {:error, reason} ->
        render(conn, "error.json", %{reason: reason})
    end
  end

  def list_matches_proto(conn, _params) do
    matches = MatchStore.list_data_proto()

    render(conn, "index.proto", matches: matches)
  end

  def show_matches_proto(conn, %{"div" => div, "season" => season}) do
    case MatchStore.find_matches(div, season) do
      {:ok, matches} ->
        matches_encoded =
        season
        |> Season.to_struct(matches)
        |> Season.encode()
        render(conn, "show.proto", matches: matches_encoded)

      {:error, reason} ->
        render(conn, "error.json", %{reason: reason})
    end
  end
end
