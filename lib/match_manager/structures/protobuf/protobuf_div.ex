defmodule MatchManager.Protobuf.Div do
  alias MatchManager.Protobuf.Season
  alias MatchManager.Protobuf.Structures.MatchResults.Div, as: DivStruct

  def to_struct(div, seasons) do
    DivStruct.new(
      div: div,
      seasons: Season.to_struct(seasons)
    )
  end

  def to_struct(divs) do
    Enum.map(divs, fn {div, seasons} ->
      to_struct(div, seasons)
    end)
  end
end
