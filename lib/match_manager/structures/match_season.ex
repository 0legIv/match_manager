defmodule MatchManager.Structures.MatchSeason do
  alias MatchManager.Structures.Match

  defstruct season: nil,
            matches: nil

  @type t() :: %__MODULE__{
          season: String.t(),
          matches: list(%Match{})
        }

  def to_struct(season, matches) do
    %__MODULE__{
      season: season,
      matches: Enum.map(matches, &Match.to_struct(&1))
    }
  end

  def to_struct(seasons) do
    Enum.map(seasons, fn {season, matches} ->
      to_struct(season, matches)
    end)
  end

  def from_struct(season_struct) do
    matches =
      Enum.map(season_struct.matches, fn match ->
        Match.from_struct(match)
      end)

    %{season_struct | matches: matches}
    |> Map.from_struct()
  end
end
