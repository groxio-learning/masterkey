defmodule MasterKey.Game do
  alias MasterKey.Game.{Board, Score}
  
  def to_map(board) do
    %{
      status: Board.status(board), 
      rows: rows(board)
    }
  end

  defp rows(board) do
    Enum.map(
      board.guesses, 
      &row(&1, board.answer)
    )
  end
  
  defp row(guess, answer) do
    %{ 
      guess: guess, 
      score: Score.new(answer, guess) |> Map.from_struct
    }
  end
end