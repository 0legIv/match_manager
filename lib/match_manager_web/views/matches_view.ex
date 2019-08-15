defmodule MatchManagerWeb.MatchView do
  use MatchManagerWeb, :view

  def render("show.proto", %{matches: matches}),
    do: matches

  def render("index.proto", %{matches: matches}),
    do: matches

  def render("index.json", %{matches: matches}) do
    %{
      success: true,
      data: matches
    }
  end

  def render("show.json", %{div: div, season: season, matches: matches}) do
    %{
      success: true,
      data: %{
        div: div,
        season: season,
        matches: matches
      }
    }
  end

  def render("error.json", %{reason: reason}) do
    %{
      success: false,
      error: reason
    }
  end
end
