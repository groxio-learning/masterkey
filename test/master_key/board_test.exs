defmodule BoardTest do
  use ExUnit.Case
  
  alias MasterKey.Game.Board

  test "boards have default fields" do
    board = board()
    assert board.answer == [1, 2, 3, 4]
    assert board.guesses == []
  end
  
  test "boards make moves" do
    actual = 
      board()
      |> Board.guess([5, 6, 7, 8])
      |> Board.guess([1, 2, 3, 4])
    
    assert length(actual.guesses) == 2
    assert actual.guesses == [[1, 2, 3, 4], [5, 6, 7, 8]]
  end
  
  test "random answer does not repeat" do
    all_random_answers_have_four_unique_numbers = 
      (1..100)
      |> Enum.map(fn _ -> Board.new().answer end)
      |> Enum.all?(fn answer -> (answer |> Enum.uniq |> length) == 4 end)

    assert all_random_answers_have_four_unique_numbers
  end
  
  test "assert ten move loser has losing status" do
    assert Board.status(ten_move_loser()) == :lost
  end

  test "assert ten move winner has winning status" do
    assert Board.status(ten_move_winner()) == :won
  end
  
  test "assert nine move game has playing status" do
    assert Board.status(nine_move_game()) == :playing
  end
  
  def board do
    Board.new([1, 2, 3, 4])
  end
  
  def nine_move_game do
    board()
    |> Board.guess([5, 6, 7, 8])
    |> Board.guess([5, 6, 7, 8])
    |> Board.guess([5, 6, 7, 8])
    |> Board.guess([5, 6, 7, 8])
    |> Board.guess([5, 6, 7, 8])
    |> Board.guess([5, 6, 7, 8])
    |> Board.guess([5, 6, 7, 8])
    |> Board.guess([5, 6, 7, 8])
    |> Board.guess([5, 6, 7, 8])
  end
  
  def ten_move_loser do
    nine_move_game()
    |> Board.guess([5, 6, 7, 8])
  end
  
  def ten_move_winner do
    nine_move_game()
    |> Board.guess([1, 2, 3, 4])
  end
  
end
