defmodule MatchManager.Protobuf.Season do
  alias MatchManager.Protobuf.Match, as: Match
  alias MatchManager.Protobuf.Structures.MatchResults.Div.Season, as: SeasonStruct

  def to_struct(season, matches) do
    SeasonStruct.new(
      season: season,
      matches: Enum.map(matches, &Match.to_struct(&1))
    )
  end

  def to_struct(seasons) do
    Enum.map(seasons, fn {season, matches} ->
      to_struct(season, matches)
    end)
  end

  def encode(season),
    do: SeasonStruct.encode(season)
end
