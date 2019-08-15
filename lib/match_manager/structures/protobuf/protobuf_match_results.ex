defmodule MatchManager.Protobuf.MatchResults do
  alias MatchManager.Protobuf.Div
  alias MatchManager.Protobuf.Structures.MatchResults, as: MatchResultsStruct

  def to_struct(divs),
    do: MatchResultsStruct.new(divs: Div.to_struct(divs))

  def encode(match_results),
    do: MatchResultsStruct.encode(match_results)
end
