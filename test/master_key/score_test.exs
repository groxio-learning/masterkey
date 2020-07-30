defmodule ScoreTest do
  use ExUnit.Case
  alias MasterKey.Game.Score
  
  test "tracks reds and whites" do
    actual = none()
    
    assert actual.reds == 0
    assert actual.whites == 0
  end

  test "counts slots" do
    assert Score.slots([1, 2, 3, 4]) == 4
  end
  
  test "counts misses" do
    assert Score.misses([1, 2, 3, 4], [1, 5, 6, 7]) == 3
    assert Score.misses([1, 2, 3, 4], [1, 2, 3, 7]) == 1
    assert Score.misses([1, 2, 3, 4], [1, 2, 3, 4]) == 0
  end
  
  test "accurately_scores reds" do
    assert almost().reds == 3
  end
  
  test "accurately_scores whites" do
    assert two_white().whites == 2
  end
  
  test "accurately scores reds and whites" do
    assert two_white_two_red().whites == 2
    assert two_white_two_red().reds == 2
  end

  def none, do: Score.new([1, 2, 3, 4], [5, 6, 7, 8])
  def almost, do: Score.new([1, 2, 3, 4], [1, 2, 3, 3])
  def two_white, do: Score.new([1, 2, 3, 4], [5, 6, 1, 2])
  def two_white_two_red, do: Score.new([1, 2, 3, 4], [1, 2, 4, 3])
end