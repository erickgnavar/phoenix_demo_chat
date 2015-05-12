defmodule DemoChat.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", auth, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", %{"message" => message}, socket) do
    broadcast! socket, "new_message", %{message: message}
    {:noreply, socket}
  end

  def handle_out("new_message", payload, socket) do
    push socket, "new_message", payload
    {:noreply, socket}
  end
end
