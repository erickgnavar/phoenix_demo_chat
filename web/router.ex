defmodule DemoChat.Router do
  use DemoChat.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DemoChat do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  socket "/ws", DemoChat do
    channel "rooms:*", RoomChannel
  end

  # Other scopes may use custom stacks.
  # scope "/api", DemoChat do
  #   pipe_through :api
  # end
end
