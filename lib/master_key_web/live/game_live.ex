defmodule MasterKeyWeb.GameLive do
  use MasterKeyWeb, :live_view
  alias MasterKeyWeb.{BoardComponent, GuessFormData}
  alias MasterKey.Game

  def mount(params, _session, socket) do
    {:ok, start(socket, params)}
  end
  
  def start(socket, params) do
    socket 
    |> new_board(params) 
    |> guess_changeset(%{})
    |> game_state
  end
  
  defp new_board(socket, %{"answer" => answer}) do
    assign(socket, board: Game.new_board(answer) ) 
  end
  defp new_board(socket, _) do
    assign(socket, board: Game.new_board())
  end
  
  defp game_state(socket) do
    assign(socket, game: Game.to_map(socket.assigns.board))
  end
  
  defp guess_changeset(socket, params) do
    assign(socket, changeset: GuessFormData.changeset(params))
  end
  
  def render(%{game: %{status: :lost}}=assigns) do
    ~L"""
    <h1>You're out of time! Play again?</h1>
    <%= live_component(@socket, BoardComponent, game: @game) %>
    <button phx-click="play">Restart</button>
    """
  end

  def render(%{game: %{status: :won}}=assigns) do
    ~L"""
    <h1>You guessed the master key! Play again?</h1>
    <%= live_component(@socket, BoardComponent, game: @game) %>
    <button phx-click="play">Restart</button>
    """
  end
  
  def render(assigns) do
    ~L"""
      <h1>Welcome to MasterKey! </h1>

      <%= live_component(@socket, BoardComponent, game: @game) %>
      <%= render_form(assigns) %>
    """
  end
  
  def render_form(assigns) do
    ~L"""
      <%= form_for @changeset, "#", [as: :guess, phx_change: :validate, phx_submit: :guess] ,fn f -> %>
        <label>
          Guess: <%= text_input f, :guess %>
        </label>
        <%= error_tag f, :guess %>
        <%= submit "Submit", disabled: !@changeset.valid? %>
      <% end %>    
    """
  end
    
  def guess(socket, guess) do
    socket 
    |> assign(board: Game.guess(socket.assigns.board, guess))
    |> game_state
  end
  
  def handle_event("validate", %{"guess" => params}, socket) do
    {:noreply, guess_changeset(socket, params)}
  end
  def handle_event("guess", %{"guess" => params}, socket) do
    {:noreply, guess(socket, params["guess"])}
  end
  def handle_event("play", _, socket) do
    {:noreply, start(socket, %{})}
  end
  
end