defmodule MasterKey.Game.Score do
  defstruct [:reds, :whites]
  
  def new(answer, guess) do
    %{ reds: reds(answer, guess), whites: whites(answer, guess)}
  end
  
  # note: these would typically be private, but they are public for test-first exercise
  def reds(answer, score) do
    answer
    |> Enum.zip(score)
    |> Enum.count(fn {answer, guess} -> answer == guess end)
  end
  
  def slots(answer), do: length(answer)
  
  def misses(answer, guess) do
    (guess -- answer) 
    |> length
  end
  
  def whites(answer, guess) do 
    slots(answer) - reds(answer, guess) - misses(answer, guess)
  end
end