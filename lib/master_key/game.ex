defmodule MasterKey.Game do
  alias MasterKey.Game.{Board, Score}

  def new_board(answer) do
    answer |> convert |> Board.new
  end
  
  def new_board do
    Board.new
  end
  
  def guess(board, guess) do
    Board.guess(board, convert(guess))
  end

  def to_map(board) do
    %{
      status: Board.status(board), 
      rows: rows(board)
    }
  end
  
  def valid_guess?(string) when not is_binary(string), do: false
  def valid_guess?(string) do
    all_valid_integers = 
      string 
      |> convert
      |> Enum.all?(fn n -> n in (1..8) end)
    
    all_valid_integers and String.length(string) == 4
  rescue 
    _e -> false
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
      score: Score.new(answer, guess)
    }
  end
  
  defp convert(string), do: string |> String.to_integer |> Integer.digits
end