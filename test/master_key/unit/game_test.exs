defmodule GameTest do
  use ExUnit.Case
  
  alias MasterKey.Game
  alias MasterKey.Game.Board

  test "Board constructors return boards" do
    assert %Board{} = Game.new_board()
    assert %Board{} = Game.new_board("1234")
  end
  
  test "to_map for winning game" do
    actual = new_winner()
    final_move = actual.rows |> hd
    
    assert actual.status == :won
    assert final_move.score.reds == 4
    assert final_move.guess == [1, 2, 3, 4]
    
  end
  
  defp new_winner do
    Game.new_board("1234")
    |> Game.guess("1235")
    |> Game.guess("1236")
    |> Game.guess("1234")
    |> Game.to_map
  end
end