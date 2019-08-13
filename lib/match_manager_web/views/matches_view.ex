defmodule MatchManagerWeb.MatchView do
  use MatchManagerWeb, :view

  def render("show.json", %{matches: matches}) do
    matches
  end

  def render("index.json", %{matches: matches}) do
    matches
  end

  def render("show.proto", %{matches: matches}) do
    matches
  end

  def render("index.proto", %{matches: matches}) do
    matches
  end
end
