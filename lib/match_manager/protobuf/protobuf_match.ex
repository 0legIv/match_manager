defmodule MatchManager.Protobuf.Match do
    alias MatchManager.Protobuf.Structures.Div.Season.Match, as: MatchStruct

    def to_struct(match) do
        MatchStruct.new(
            away_team: Map.get(match, "AwayTeam"),
            date: Map.get(match, "Date"),
            div: Map.get(match, "Div"),
            ftag: Map.get(match, "FTAG"),
            fthg: Map.get(match, "FTHG"),
            ftr: Map.get(match, "FTR"),
            htag: Map.get(match, "HTAG"),
            hthg: Map.get(match, "HTHG"),
            htr: Map.get(match, "HTR"),
            home_team: Map.get(match, "HomeTeam"),
            season: Map.get(match, "Season")
        )
    end

    def encode_match(match_struct) do
        MatchStruct.encode(match_struct)
    end
end