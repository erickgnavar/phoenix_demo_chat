defmodule DemoChat.Message do
  use DemoChat.Web, :model
  import Ecto.Query

  schema "messages" do
    field :body, :string

    timestamps
  end

  @required_fields ~w(body)
  @optional_fields ~w()

  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:body, min: 1)
  end

  def latest(query) do
    query
    |> order_by([m], desc: m.inserted_at)
    |> limit([m], 10)
  end
end
