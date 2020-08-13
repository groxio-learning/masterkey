defmodule MasterKeyWeb.BoardComponent do
  use Phoenix.LiveComponent

  def update(assigns, socket) do
    {:ok, assign(socket, assigns)}
  end
  
  def render(assigns) do
    ~L"""
    <div class="container">
      <%= for row <- @game.rows do %>
        <div class="row">
          <div class="column">Guess: <%= guess row.guess %></div>
          <div class="column">Score: <%= score row.score %></div>
        </div class="row">
      <% end %>
    </div>
    """
  end
  
  defp score(%{reds: reds, whites: whites}) do
    String.duplicate("R", reds) <> String.duplicate("W", whites)
  end
  
  defp guess(guess) do
    guess 
    |> Enum.map(&to_string/1)
    |> Enum.join
  end
end