defmodule MasterKeyWeb.GuessFormData do
  alias MasterKey.Game
  
  @new_form_data %{}
  @types %{guess: :string}
  
  def changeset(params) do
    {@new_form_data, @types}
    |> Ecto.Changeset.cast(params, Map.keys(@types))
    |> validate_guess
    |> Ecto.Changeset.validate_required(:guess)
    |> Map.put(:action, :validate)
  end
  
  def validate_guess(changeset) do
    Ecto.Changeset.validate_change(changeset, :guess, fn (field, value) ->
      check_guess_errors(field, Game.valid_guess?(value))
    end)
  end
  
  def check_guess_errors(field, false) do
    [{field, "Guesses must be four numbers"}]
  end
  def check_guess_errors(_field, true), do: []
end