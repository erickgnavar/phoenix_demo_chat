defmodule DemoChat.PageController do
  use DemoChat.Web, :controller
  alias DemoChat.Message

  plug :action

  def index(conn, _params) do
    messages = Message
    |> Message.latest
    |> Repo.all 
    render conn, "index.html", messages: messages
  end
end
