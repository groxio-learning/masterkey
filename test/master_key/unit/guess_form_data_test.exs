defmodule GuessFormDataTest do
  use ExUnit.Case
  
  alias MasterKeyWeb.GuessFormData
  
  test "guess data produces changeset" do
    assert %Ecto.Changeset{} = GuessFormData.changeset(%{})
  end
  
  test "a guess is required" do
    changeset = GuessFormData.changeset(%{"guess" => ""})
    
    refute changeset.valid?
  end

  test "guesses should be numeric" do
    changeset = GuessFormData.changeset(%{"guess" => "abc"})
    error_messages = [guess: {"Guesses must be four numbers from 1-8", []}]
    
    refute changeset.valid?
    assert changeset.errors == error_messages
  end
  
  test "guesses must be four characters" do
    changeset = GuessFormData.changeset(%{"guess" => "123"})
    
    refute changeset.valid?
  end

  
  test "four number guesses are valid" do
    changeset = GuessFormData.changeset(%{"guess" => "1234"})
    
    assert changeset.valid?
  end

end