defmodule GameLiveInitTest do
  use ExUnit.Case
  
  alias MasterKey.Game.Board
  alias MasterKeyWeb.GameLive
  
  test "Mount with an answer assigns game, board, changeset" do
    assigns = new_socket().assigns
    
    assert %Board{answer: [1,2,3,4], guesses: []} = assigns.board
    assert %{rows: [], status: :playing} = assigns.game
    assert %Ecto.Changeset{} = assigns.changeset
  end
  
  test "Renders a title" do
    socket = new_socket()
    
    assert render_static(socket) =~  "<h1>Welcome to MasterKey!</h1>"
  end
    
  def new_socket do
    {:ok, socket} = 
      GameLive.mount(
        %{"answer" => "1234"}, %{}, %Phoenix.LiveView.Socket{}
      )
    
    socket
  end
  
  def render_static(socket) do
    GameLive.render(socket.assigns).static
    |> Enum.join("\n")
  end
end