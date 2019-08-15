defmodule MatchManager.Structures.MatchDiv do
  alias MatchManager.Structures.MatchSeason

  defstruct div: nil,
            seasons: nil

  @type t() :: %__MODULE__{
          div: String.t(),
          seasons: list(%MatchSeason{})
        }

  def to_struct(div, seasons) do
    %__MODULE__{
      div: div,
      seasons: MatchSeason.to_struct(seasons)
    }
  end

  def to_struct(divs) do
    Enum.map(divs, fn {div, seasons} ->
      to_struct(div, seasons)
    end)
  end

  def from_struct(divs) when is_list(divs) do
    Enum.map(divs, &from_struct(&1))
  end

  def from_struct(div_struct) do
    seasons =
      Enum.map(div_struct.seasons, fn seasons ->
        MatchSeason.from_struct(seasons)
      end)

    %{div_struct | seasons: seasons}
    |> Map.from_struct()
  end
end
