defmodule MatchManagerWeb.MatchController do
    use MatchManagerWeb, :controller

    alias MatchManager.MatchStore

    def list_matches(conn, _params) do
        matches = MatchStore.list_data()

        render(conn, "index.json", matches: matches)
    end

    def show_matches(conn, %{"div" => div, "season" => season}) do
        matches = MatchStore.find_matches(div, season)

        render(conn, "show.json", matches: matches)
    end
end