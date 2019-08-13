defmodule MatchManagerWeb.MatchController do
  use MatchManagerWeb, :controller

  alias MatchManager.MatchStore
  alias MatchManager.Protobuf.Match

  def list_matches(conn, _params) do
    matches = MatchStore.list_data_json()

    render(conn, "index.json", matches: matches)
  end

  def list_matches_protobuf(conn, _params) do
    matches = %{}

    struct = Match.to_struct(matches)


    render(conn, "index.proto", matches: Match.encode_match(struct))
  end

  def show_matches(conn, %{"div" => div, "season" => season}) do
    matches = MatchStore.find_matches(div, season)

    render(conn, "show.json", matches: matches)
  end
end
