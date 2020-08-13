defmodule MasterKey.Game.Board do
  defstruct [:answer, guesses: []]
  
  def new do
    __struct__(answer: random_answer())
  end
  def new(answer) do
    __struct__(answer: answer)
  end
  
  defp random_answer do
    (1..8)
    |> Enum.shuffle
    |> Enum.take(4)
  end
  
  def guess(board, guess) do
    %{board| guesses: [guess|board.guesses]}
  end
  
  defp won?(%{guesses: [answer|_guesses], answer: answer}), do: true
  defp won?(_board), do: false
  
  defp lost?(%{guesses: guesses}), do: length(guesses) >= 10
  
  defp status(true, _), do: :won
  defp status(_, true), do: :lost
  defp status(_, _), do: :playing

  def status(board), do: status(won?(board), lost?(board))
end