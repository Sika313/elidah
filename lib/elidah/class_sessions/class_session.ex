defmodule Elidah.CLASS_SESSIONS.Class_session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "class_session" do
    field :grade, :string
    field :subject, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(class_session, attrs) do
    class_session
    |> cast(attrs, [:grade, :subject])
    |> validate_required([:grade, :subject])
  end
end
