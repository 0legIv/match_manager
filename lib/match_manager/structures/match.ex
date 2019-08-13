defmodule MatchManager.Structures.Match do
  defstruct away_team: nil,
            date: nil,
            div: nil,
            ftag: nil,
            fthg: nil,
            ftr: nil,
            htag: nil,
            hthg: nil,
            htr: nil,
            home_team: nil,
            season: nil

  @type t() :: %__MODULE__{
          away_team: String.t(),
          date: String.t(),
          div: String.t(),
          ftag: String.t(),
          fthg: String.t(),
          ftr: String.t(),
          htag: String.t(),
          hthg: String.t(),
          htr: String.t(),
          home_team: String.t(),
          season: String.t()
        }

  @spec to_struct(Map.t()) :: %__MODULE__{}
  def to_struct(match) do
    %__MODULE__{
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
    }
  end

  def from_struct(match_struct),
    do: Map.from_struct(match_struct)
end
