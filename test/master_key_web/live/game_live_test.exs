defmodule MasterKeyWeb.GameLiveTest do
  use MasterKeyWeb.ConnCase

  import Phoenix.LiveViewTest
  alias  MasterKeyWeb.BoardComponent
  alias MasterKey.Game

  test "disconnected and connected render", %{conn: conn} do
    {:ok, game_live, disconnected_html} = live(conn, "/game/1234")
    assert disconnected_html =~ "<h1>Welcome to MasterKey!</h1>"
    assert render(game_live) =~ "<h1>Welcome to MasterKey!</h1>"
  end
  
  test "renders form component" do
    rendered = render_component(BoardComponent, game: game_winner())
    
    assert rendered =~ "1234"
    assert rendered =~ "RRRR"

    assert rendered =~ "1236"
    assert rendered =~ "RRR"

    assert rendered =~ "1236"
    assert rendered =~ "RRWW"
  end
  
  test "changes to invalid move", %{conn: conn} do
    {:ok, game_live, _html} = live(conn, "/game/1234")
    assert render(game_live) =~ "<h1>Welcome to MasterKey!</h1>"
    
    game_live 
    |> element("#game_form") 
    |> render_change(%{"guess" => %{"guess" => "123"}})
      
    assert render(game_live) =~ "Guesses must be four numbers from 1-8"
  end

  test "commits winning move", %{conn: conn} do
    {:ok, game_live, _html} = live(conn, "/game/1234")
    assert render(game_live) =~ "<h1>Welcome to MasterKey!</h1>"
    
    move(game_live, "1233")
    move(game_live, "1234")
        
    assert render(game_live) =~ "You guessed the master key! Play again?"
  end
  
  test "commits 10 losing moves", %{conn: conn} do
    {:ok, game_live, _html} = live(conn, "/game/1234")
    assert render(game_live) =~ "<h1>Welcome to MasterKey!</h1>"
    
    move(game_live, "1231")
    move(game_live, "1232")
    move(game_live, "1233")
    move(game_live, "1235")
    move(game_live, "1236")
    move(game_live, "1237")
    move(game_live, "1238")
    move(game_live, "1251")
    move(game_live, "1252")
    move(game_live, "1253")
        
    assert render(game_live) =~ "out of time! Play again?"
  end
  
  
  def move(view, move) do
    view
    |> element("#game_form") 
    |> render_submit(%{"guess" => %{"guess" => move}})
  end
  
  defp game_winner do
    Game.new_board("1234")
    |> Game.guess("1243")
    |> Game.guess("1236")
    |> Game.guess("1234")
    |> Game.to_map
  end
end
