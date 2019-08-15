defmodule MatchManager.MatchControllerTest do
  alias MatchManager.MatchStore

  use MatchManagerWeb.ConnCase

  @test_div "D1"
  @test_season "201617"

  @wrong_div "Wrong"
  @wrong_season "12345"

  test "list matches when there is no data", %{conn: conn} do
    MatchStore.update_state_from_file("wrong_file.csv")
    conn = get(conn, Routes.match_path(conn, :list_matches))
    response = json_response(conn, 200)

    MatchStore.update_state_from_file("data.csv")
    assert %{"error" => "no_data", "success" => false} == response
  end

  test "list matches when data exists", %{conn: conn} do
    conn = get(conn, Routes.match_path(conn, :list_matches))
    response = json_response(conn, 200)

    assert %{"data" => data, "success" => true} = response
  end

  test "find matches when data exsists", %{conn: conn} do
    conn = get(conn, Routes.match_path(conn, :show_matches, @test_div, @test_season))

    response = json_response(conn, 200)

    assert %{
             "data" => %{"div" => @test_div, "season" => @test_season, "matches" => matches},
             "success" => true
           } = response
  end

  test "find matches when div or season is wrong", %{conn: conn} do
    conn = get(conn, Routes.match_path(conn, :show_matches, @wrong_div, @wrong_season))

    response = json_response(conn, 200)

    assert %{"error" => "match_not_found", "success" => false} = response
  end
end
