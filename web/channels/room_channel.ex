defmodule DemoChat.RoomChannel do
  use Phoenix.Channel
  alias DemoChat.Repo
  alias DemoChat.Message

  def join("rooms:lobby", _, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", %{"message" => message}, socket) do
    changeset = Message.changeset(%Message{}, %{body: message})
    Repo.insert(changeset)
    broadcast! socket, "new_message", %{message: message}
    {:noreply, socket}
  end

  def handle_out("new_message", payload, socket) do
    push socket, "new_message", payload
    {:noreply, socket}
  end
end
